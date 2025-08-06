import 'dart:async';
import 'package:app/src/modules/user/presenters/viewmodels/search_address_viewmodel.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:app/src/modules/user/domain/usecases/address_user_usecase.dart';
import 'package:app/src/modules/user/domain/usecases/user_usecase.dart';
import 'package:app/src/modules/user/presenters/pages/address_nick_name_page.dart';
import 'package:app/src/modules/user/presenters/pages/search_address_manually_page.dart';
import 'package:app/src/modules/user/presenters/pages/list_address_page.dart';
import 'package:app/src/modules/user/presenters/pages/name_page.dart';
import 'package:app/src/modules/user/presenters/pages/phone_confirm_page.dart';
import 'package:app/src/modules/user/presenters/pages/phone_page.dart';
import 'package:app/src/modules/user/presenters/pages/search_address_page.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UserModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => SearchAddressViewmodel(addressApi: i.get())),
        Bind.factory((i) => DeliveryAreasRepository(http: i.get())),
        Bind.factory((i) => SearchAddressApi(client: ClientDio(baseOptions: HttpUtils.api()))),
        Bind.factory((i) => AuthRepository(http: i.get())),
        Bind.factory((i) => AddressRepository(http: i.get())),
        Bind.factory((i) => AddressUserUsecase(addressApi: i.get(), addressRepo: i.get(), authRepo: i.get(), userUsecase: i.get())),
        Bind.factory((i) => UserUsecase(authRepo: i.get(), refreshTokenMicroService: i.get())),
        Bind.factory((i) => PhoneRefreshTokenService(authRepository: i.get())),
        Bind.singleton((i) => UserStore(userAddressUsecase: i.get(), userUsecase: i.get(), localStorage: i.get())),
        Bind.singleton((i) => TwillioMessageRepository(http: ClientDio())),
        Bind.factory((i) => VerificationCodeApi(client: ClientDio(baseOptions: HttpUtils.api()), jwtSecretKey: Env.secretKey)),
        Bind.singleton((i) => PhoneAuthMicroService(smsRepo: i.get(), verificationCodeApi: i.get(), authRepo: i.get(), addressRepo: i.get(), refreshTokenService: i.get())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.nameRelative,
          child: (context, state) => const NamePage(),
          redirect: (context, state) async {
            final userViewmodel = Modular.get<UserStore>();
            final authPhoneMicroService = Modular.get<PhoneAuthMicroService>();
            await userViewmodel.loadCache();
            authPhoneMicroService.setUser(userViewmodel.userDto.buildUser());
            return null;
          },
        ),
        ChildRoute(Routes.phoneRelative, child: (context, state) => const PhonePage()),
        ChildRoute(Routes.userAddressesRelative, child: (context, state) => const ListAdressPage()),
        ChildRoute(Routes.phoneConfirmRelative, child: (context, state) => const PhoneConfirmPage()),
        ChildRoute(Routes.searchAddressRelative, child: (context, state) => const SearchAddressPage()),
        ChildRoute(Routes.searchAddressManuallyRelative, child: (context, state) => const SearchAddressManuallyPage()),
        ChildRoute(Routes.addressNicknameRelative, child: (context, state) => const AddressNickNamePage()),
      ];
}
