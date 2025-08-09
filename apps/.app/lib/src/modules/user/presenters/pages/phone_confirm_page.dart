import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/notifiers/delivery_area_notifier.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/templates/login_phone/domain/dtos/phone_micro_dto.dart';
import 'package:ui/templates/login_phone/domain/services/phone_auth_micro_service.dart';
import 'package:ui/templates/login_phone/presenters/pages/phone_confirm_micro_page.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class PhoneConfirmPage extends StatefulWidget {
  const PhoneConfirmPage({super.key});

  @override
  State<PhoneConfirmPage> createState() => _PhoneConfirmPageState();
}

class _PhoneConfirmPageState extends State<PhoneConfirmPage> {
  late final authMicroServie = context.read<PhoneAuthMicroService>();
  late final userViewmodel = context.read<UserStore>();
  late final deliveryAreaNotifier = context.read<DeliveryAreaNotifier>();
  PhoneMicroDto? get phone => authMicroServie.getPhoneModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (phone == null || phone!.verifyCode.isEmpty) {
      _login(context);
      // context.pop();
      // }
    });
    super.initState();
  }

  Future<void> _login(BuildContext context) async {
    Loader.show(context);
    // if (authMicroServie.verifyCodeIsValid(code) == false) {
    //   banner.showError(context.i18n.codigoInvalido);
    //   Loader.hide();
    //   return;
    // }
    try {
      final auth = await authMicroServie.login(user: authMicroServie.user);
      Sentry.configureScope((scope) => scope.setUser(SentryUser(id: auth.user!.id, name: auth.user!.name)));
      await userViewmodel.loadAdress();
      if (AuthNotifier.instance.auth.user!.getAddress != null) {
        await deliveryAreaNotifier.loadDeliveryTax(address: AuthNotifier.instance.auth.user!.getAddress!, establishmentAddress: userViewmodel.establishmentAdress!, deliveryMethod: deliveryAreaNotifier.deliveryMethod!);
      }
      if (userViewmodel.navigationMode.isLoginDelivery) {
        final address = await userViewmodel.userAddressUsecase.saveNewAddress(address: userViewmodel.userDto.address!);
        userViewmodel.updateUserDto(userViewmodel.userDto.copyWith(address: address));
        await deliveryAreaNotifier.loadDeliveryTax(address: AuthNotifier.instance.auth.user!.getAddress!, establishmentAddress: userViewmodel.establishmentAdress!, deliveryMethod: deliveryAreaNotifier.deliveryMethod!);
      }
    } catch (e) {
      e.isA<AddressOutOfDeliveryRadiusException>((value) {
        final message = InternalExceptionHelper.getMessage(code: value.code, language: LocaleNotifier.instance.language);
        // userViewmodel.updateUserDto(userViewmodel.userDto.copyWith(addressSaveId: ''));
        return banner.showError(message);
      });
    } finally {
      Loader.hide();

      if (context.mounted) {
        userViewmodel.navigateFinish(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (phone == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return PhoneConfirmMicroPage(
      phone: phone!,
      isEdit: userViewmodel.navigationMode.isEditPhone,
      loginAndConfirmVerifyCode: (code) async {
        await _login(context);
      },
      onUpdateNumber: (code) async {
        if (!authMicroServie.verifyCodeIsValid(code)) {
          banner.showError(context.i18n.codigoInvalido);
          return;
        }
        if (userViewmodel.phoneIsDifferent) {
          try {
            Loader.show(context);
            await authMicroServie.updatePassword(user: authMicroServie.user);
            if (context.mounted) {
              banner.showSucess(context.i18n.numeroAtualizadoSucesso);
              userViewmodel.navigateFinish(context);
            }
          } catch (e) {
            banner.showError(e.toString());
          } finally {
            Loader.hide();
          }

          return;
        }
        userViewmodel.navigateFinish(context);
      },
      onBackPage: () {
        context.pop();
      },
      onResendCodeWpp: () async {
        try {
          Loader.show(context);
          final newCode = await authMicroServie.sendWppCode(phone: phone!.phone, countryCode: phone!.countryCode, locale: LocaleNotifier.instance.locale);
          authMicroServie.updateVerifyCode(newCode);
        } finally {
          Loader.hide();
        }
      },
      onResendCodeSms: () {
        final newCode = Utils.generateRandomCodeOtp();
        authMicroServie.updateVerifyCode(newCode);
        authMicroServie.sendSmsCode(phone: phone!.phone, countryCode: phone!.countryCode, verifyCode: newCode);
      },
    );
  }
}
