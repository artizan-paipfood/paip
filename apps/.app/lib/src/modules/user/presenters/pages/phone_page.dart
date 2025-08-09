import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  late final controller = context.read<PhoneAuthMicroService>();
  late final userViewmodel = context.read<UserStore>();

  @override
  Widget build(BuildContext context) {
    return PhoneLoginMicroPage(
      initialLocale: LocaleNotifier.instance.locale.name,
      initialValue: userViewmodel.userDto.phone,
      countries: Countries.countries,
      title: context.i18n.insiraTelefoneContato,
      onSubmit: (phone) async {
        try {
          Loader.show(context);
          controller.setUserPhone(countryCode: phone.countryCode, phone: phone.phone);
          // try {
          //   // final code = await controller.sendWppCode(countryCode: phone.countryCode, phone: phone.phone, locale: LocaleNotifier.instance.locale);
          //   // controller.updateVerifyCode(code);
          // } catch (e) {}
          userViewmodel.changePhone(phoneCountryCode: phone.countryCode, phone: phone.phone);
          await Future.delayed(50.milliseconds);
          if (context.mounted) {
            banner.showSucess("${context.i18n.codigoEnviadoWpp}/n${context.i18n.verifiqueSeuWhatsapp}");
            Go.of(context).pushNeglect(Routes.phoneConfirm);
          }
        } catch (e) {
          // banner.showError(e.toString());
        } finally {
          Loader.hide();
        }
      },
    );
  }
}
