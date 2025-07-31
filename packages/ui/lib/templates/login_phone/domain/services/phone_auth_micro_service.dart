import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/templates/login_phone/domain/dtos/phone_micro_dto.dart';

class PhoneAuthMicroService {
  final TwillioMessageRepository smsRepo;
  final VerificationCodeApi verificationCodeApi;
  final AuthRepository authRepo;
  final AddressRepository addressRepo;
  final PhoneRefreshTokenService refreshTokenService;
  PhoneAuthMicroService({
    required this.smsRepo,
    required this.verificationCodeApi,
    required this.authRepo,
    required this.addressRepo,
    required this.refreshTokenService,
  });

  UserModel _user = UserModel(addresses: []);

  UserModel get user => _user;
  String verifyCode = '';

  void setUserName(String name) => _user = _user.copyWith(name: name);

  PhoneMicroDto? get getPhoneModel {
    if (user.phone == null || user.phoneCountryCode == null) {
      return null;
    }
    return PhoneMicroDto(countryCode: user.phoneCountryCode!, phone: user.phone!, verifyCode: verifyCode);
  }

  bool verifyCodeIsValid(String code) => code == verifyCode;

  void setUser(UserModel user) => _user = user;

  void updateVerifyCode(String code) => verifyCode = code;

  void setUserPhone({required String countryCode, required String phone}) => _user = user.copyWith(phone: phone, phoneCountryCode: countryCode);

  Future<String> sendWppCode({required String countryCode, required String phone, required DbLocale locale}) async {
    final code = verificationCodeApi.sendWhatsapp(locale: locale, phone: countryCode + phone);
    return code;
  }

  Future<String> sendSmsCode({required String phone, required String countryCode, required String verifyCode}) async {
    await smsRepo.sendMessage(message: "Seu codigo de verificação é: \n$verifyCode", phone: Utils.onlyNumbersRgx("$countryCode$phone"));
    return verifyCode;
  }

  Future<AuthModel> _login({required UserModel user}) async {
    final auth = await authRepo.loginByPhone(phone: user.phone!, countryCode: user.phoneCountryCode!);
    if (auth.user?.currentAddressId != null) {
      final address = await addressRepo.getByUserId(auth.user!.id!);
      auth.user!.addresses.addAll(address);
      _user = user.copyWith(addresses: address, currentAddressId: auth.user?.currentAddressId);
    }

    _updateAuthProvider(auth: auth, user: user);

    return await authRepo.updateUser(auth: auth);
  }

  Future<AuthModel> _signUp({required UserModel user}) async {
    final auth = await authRepo.signUpByPhone(phone: user.phone!, countryCode: user.phoneCountryCode!);
    _updateAuthProvider(auth: auth, user: user);
    return await authRepo.updateUser(auth: auth);
  }

  Future<void> _updateAuthProvider({required AuthModel auth, required UserModel user}) async {
    AuthNotifier.instance.update(AuthNotifier.instance.auth.copyWith(
      user: AuthNotifier.instance.auth.user?.copyWith(
            phone: user.phone,
            phoneCountryCode: user.phoneCountryCode,
            name: user.name,
            wppPhoneFormated: user.wppPhoneFormated,
          ) ??
          user,
    ));
    await refreshTokenService.login(auth);
  }

  Future<AuthModel> login({required UserModel user}) async {
    try {
      AuthModel? auth;
      final userExists = await authRepo.userExistsByPhone(value: Utils.onlyNumbersRgx('${user.phoneCountryCode}${user.phone}'));
      if (userExists) {
        try {
          auth = await _login(user: user);
        } catch (_) {
          auth = await _signUp(user: user);
        }
      }
      try {
        auth = await _signUp(user: user);
      } catch (_) {
        auth = await _login(user: user);
      }
      auth = auth.copyWith(user: auth.user!.copyWith(name: user.name, currentAddressId: user.currentAddressId));
      return await AuthNotifier.instance.login(auth);
    } catch (e) {
      banner.showError("Erro ao efetuar login, tente novamente mais tarde", subtitle: "Erro ao efetuar login");
      rethrow;
    }
  }

  Future<void> updatePassword({required UserModel user}) async {
    await _updateAuthProvider(auth: AuthNotifier.instance.auth, user: user);
    await authRepo.updateUser(auth: AuthNotifier.instance.auth);
    await authRepo.updatePassword(
      token: AuthNotifier.instance.auth.accessToken!,
      newPassword: Utils.encodePasswordPhone(countryCode: user.phoneCountryCode!, phone: user.phone!),
    );
  }
}
