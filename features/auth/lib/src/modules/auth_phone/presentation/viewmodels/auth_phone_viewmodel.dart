import 'package:auth/auth.dart';
import 'package:auth/src/core/domain/models/user_phone_model.dart';
import 'package:auth/src/modules/auth_phone/domain/usecase/update_user_phone_usecase.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class AuthPhoneViewmodel {
  final ICacheService cache;
  final SilentAuthentication silentAuthentication;
  final UpdateUserPhoneUsecase updateUserPhoneUsecase;
  AuthPhoneViewmodel({
    required this.cache,
    required this.updateUserPhoneUsecase,
    required this.silentAuthentication,
  });

  static const Duration _expireCacheDuration = Duration(minutes: 15);

  static final _box = 'paip_auth_phone_model';

  UserPhoneModel _model = UserPhoneModel(name: '', phoneDialCode: '', phoneNumber: '');

  UserPhoneModel get model => _model;

  Future<void> setUserData(UserPhoneModel model) async {
    _model = model;
    await cache.save(box: _box, data: model.toMap(), expiresAt: DateTime.now().add(_expireCacheDuration));
  }

  Future<void> load() async {
    final data = await cache.get(box: _box);
    if (data == null) return;
    _model = UserPhoneModel.fromMap(data);
  }

  Future<AuthenticatedUser> loginOrSignUp({required PhoneNumber phoneNumber, required String fullName}) async {
    final authenticatedUser = await silentAuthentication.loginByPhone(phoneNumber: phoneNumber, fullname: fullName);
    await UserMe.refresh(userId: authenticatedUser.user.id);
    ModularEvent.fire(LoginUserEvent(authenticatedUser: authenticatedUser));
    return authenticatedUser;
  }

  Future<void> logout() async {
    await silentAuthentication.logout();
    ModularEvent.fire(LogoutUserEvent());
  }

  Future<void> updateNumberAndPassword({required PhoneNumber phoneNumber, required AuthenticatedUser authenticatedUser}) async {
    await updateUserPhoneUsecase(phoneNumber: phoneNumber, authenticatedUser: authenticatedUser);
  }
}
