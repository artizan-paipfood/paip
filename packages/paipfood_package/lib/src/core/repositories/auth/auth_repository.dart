import 'dart:async';
import 'package:core_flutter/core_flutter.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AuthRepository implements IAuthRepository {
  final IClient http;
  AuthRepository({
    required this.http,
  });

  @override
  Future<AuthModel> signUpByEmail({required String email, required String password}) async {
    final request = await http.post(
      "/auth/v1/signup",
      data: {"email": email, "password": password},
    );
    final AuthModel authModel = AuthModel.fromMap(request.data);
    await http.post(
      "/rest/v1/users_",
      data: authModel.user?.toJsonUsers_(),
      headers: {"Authorization": "Bearer ${authModel.accessToken}"},
    );
    AuthNotifier.instance.update(authModel);
    return authModel;
  }

  @override
  Future<AuthModel> signUpByPhone({required String phone, required String countryCode}) async {
    final phoneFormated = Utils.onlyNumbersRgx("$countryCode$phone");
    final request = await http.post(
      "/auth/v1/signup",
      data: {"phone": phoneFormated, "password": Utils.encodePasswordPhone(countryCode: countryCode, phone: phone)},
      headers: {"Authorization": "Bearer ${Env.supaApiKey}"},
    );
    final AuthModel resul = AuthModel.fromMap(request.data);
    final users = await http.post(
      "/rest/v1/users_",
      data: resul.user!.copyWith(phone: phone, phoneCountryCode: countryCode).toJsonUsers_(),
      headers: {"Authorization": "Bearer ${resul.accessToken}"},
    );
    final List user = users.data;
    AuthNotifier.instance.update(resul.copyWith(user: UserModel.fromMap(user.first)));
    return AuthNotifier.instance.auth;
  }

  @override
  Future<AuthModel> loginByEmail({required String email, required String password}) async {
    final request = await http.post(
      "/auth/v1/token?grant_type=password",
      data: {"email": email, "password": password},
    );
    AuthModel auth = AuthModel.fromMap(request.data);
    final user = await getUser(auth: auth);
    auth = auth.copyWith(user: user);
    AuthNotifier.instance.update(auth);
    return auth;
  }

  @override
  Future<AuthModel> loginByPhone({required String phone, required String countryCode}) async {
    if (phone.length < 4 || countryCode.length > 4) throw Exception("Invalid phone number");
    final phoneFormated = Utils.onlyNumbersRgx("$countryCode$phone");
    final request = await http.post(
      "/auth/v1/token?grant_type=password",
      data: {"phone": phoneFormated, "password": Utils.encodePasswordPhone(countryCode: countryCode, phone: phone)},
    );

    AuthModel auth = AuthModel.fromMap(request.data);
    final user = await getUser(auth: auth);
    auth = auth.copyWith(user: user);
    AuthNotifier.instance.update(auth);

    return auth;
  }

  @override
  Future<void> logout({required AuthModel auth}) async {
    await http.post("/auth/v1/logout", headers: {"Authorization": "Bearer ${auth.accessToken}"});
    AuthNotifier.instance.logout();
  }

  @override
  Future<AuthModel> refreshToken({required String refreshToken}) async {
    final request = await http.post(
      "/auth/v1/token?grant_type=refresh_token",
      data: {"refresh_token": refreshToken},
    );

    final AuthModel authModel = AuthModel.fromMap(request.data);

    final reqUser_ = await http.get(
      "/rest/v1/users_?id=eq.${authModel.user!.id}&select=*",
      headers: {"Authorization": "Bearer ${authModel.accessToken}"},
    );
    final List<UserModel> user_ = reqUser_.data.map<UserModel>((user) {
      return UserModel.fromMap(user);
    }).toList();

    if (authModel.user!.email != user_.first.email) {
      await updateUser(auth: authModel);
    }
    AuthModel result = authModel.copyWith(
      user: user_.first.copyWith(email: authModel.user!.email),
    );
    result = result.copyWith(user: user_.first);

    AuthNotifier.instance.update(result);
    return result;
  }

  @override
  Future<AuthModel> updateUser({
    required AuthModel auth,
  }) async {
    await http.put(
      "/auth/v1/user",
      data: auth.user!.toJson(),
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
    );

    final request = await http.patch(
      "/rest/v1/users_?id=eq.${auth.user?.id}",
      data: auth.user!.toJsonUsers_(),
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
    );
    final List<UserModel> result = request.data.map<UserModel>((user) {
      return UserModel.fromMap(user);
    }).toList();

    auth = auth.copyWith(user: result.first);
    return auth;
  }

  @override
  Future<bool> userExistsByPhone({required String value}) async {
    final request = await http.post(
      "/rest/v1/rpc/func_user_exists_by_phone",
      headers: {"Authorization": "Bearer ${Env.supaApiKey}"},
      data: {"body": value},
    );
    return request.data;
  }

  @override
  Future<void> updateEmail({required AuthModel auth, required String newEmail}) async {
    await http.put(
      "/auth/v1/user",
      data: {"email": newEmail},
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await http.post("/auth/v1/recover", data: {'email': email});
  }

  @override
  Future<void> updatePassword({required String token, required String newPassword}) async {
    await http.put(
      "/auth/v1/user",
      data: {"password": newPassword},
      headers: {"Authorization": "Bearer $token"},
    );
  }

  @override
  Future<UserModel> getUser({required AuthModel auth}) async {
    final request = await http.get("/rest/v1/users_?id=eq.${auth.user!.id}");

    final List<UserModel> user = request.data.map<UserModel>((user) {
      return UserModel.fromMap(user);
    }).toList();
    return user.first;
  }

  @override
  Future<bool> userExistsByEmail({required String value}) async {
    final request = await http.post(
      "/rest/v1/rpc/func_user_exists_by_email",
      headers: {"Authorization": "Bearer ${Env.supaApiKey}"},
      data: {"body": value},
    );
    return request.data;
  }
}
