import 'package:core/core.dart';
import 'package:core/src/security/encrypt.dart';

abstract class IAuthApi {
  Future<AuthenticatedUser> signUpByEmail({required String email, required String password});
  Future<AuthenticatedUser> signUpByPhone({required PhoneNumber phoneNumber, required String encryptKey});
  Future<AuthenticatedUser> loginByEmail({required String email, required String password});
  Future<AuthenticatedUser> loginByPhone({required PhoneNumber phoneNumber, required String encryptKey});
  Future<void> logout({required String accessToken});
  Future<AuthenticatedUser> refreshToken({required String refreshToken});
  Future<UserEntity> updateUser({required UserEntity user, required String accessToken});
  Future<void> updateEmail({required String email, required String accessToken});
  Future<void> forgotPassword({required String email});
  Future<void> updatePassword({required String password, required String accessToken});
  Future<void> updatePasswordPhone({required PhoneNumber phoneNumber, required String encryptKey, required String accessToken});
  Future<bool> userExistsByPhone({required PhoneNumber phoneNumber});
  Future<bool> userExistsByEmail({required String email});
  Future<UserEntity> getUser({required String accessToken});
}

class AuthApi implements IAuthApi {
  final IClient client;
  AuthApi({required this.client});
  @override
  Future<void> forgotPassword({required String email}) async {
    await client.post(
      '/auth/v1/recover',
      data: {'email': email},
    );
  }

  @override
  Future<UserEntity> getUser({required String accessToken}) async {
    final response = await client.get('/auth/v1/user', headers: {'Authorization': 'Bearer $accessToken'});
    return UserEntity.fromMap(response.data);
  }

  @override
  Future<AuthenticatedUser> loginByEmail({required String email, required String password}) async {
    final response = await client.post(
      '/auth/v1/token?grant_type=password',
      data: {'email': email, 'password': password},
    );
    return AuthenticatedUser.fromMap(response.data);
  }

  @override
  Future<AuthenticatedUser> loginByPhone({required PhoneNumber phoneNumber, required String encryptKey}) async {
    phoneNumber.validate();

    final request = await client.post(
      '/auth/v1/token?grant_type=password',
      data: {
        'phone': phoneNumber.fullPhoneOnlyNumbers(),
        'password': Encrypt.encodePasswordPhone(phoneNumber: phoneNumber, key: encryptKey),
      },
    );
    return AuthenticatedUser.fromMap(request.data);
  }

  @override
  Future<void> logout({required String accessToken}) async {
    await client.post(
      '/auth/v1/logout',
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }

  @override
  Future<AuthenticatedUser> refreshToken({required String refreshToken}) async {
    final request = await client.post(
      '/auth/v1/token?grant_type=refresh_token',
      data: {'refresh_token': refreshToken},
    );
    return AuthenticatedUser.fromMap(request.data);
  }

  @override
  Future<AuthenticatedUser> signUpByEmail({required String email, required String password}) async {
    final request = await client.post('/auth/v1/signup', data: {'email': email, 'password': password});
    return AuthenticatedUser.fromMap(request.data);
  }

  @override
  Future<AuthenticatedUser> signUpByPhone({required PhoneNumber phoneNumber, required String encryptKey}) async {
    phoneNumber.validate();
    final request = await client.post(
      '/auth/v1/signup',
      data: {
        'phone': phoneNumber.fullPhoneOnlyNumbers(),
        'password': Encrypt.encodePasswordPhone(phoneNumber: phoneNumber, key: encryptKey),
      },
    );
    return AuthenticatedUser.fromMap(request.data);
  }

  @override
  Future<void> updateEmail({required String email, required String accessToken}) async {
    await client.put(
      "/auth/v1/user",
      data: {"email": email},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  @override
  Future<void> updatePassword({required String password, required String accessToken}) async {
    await client.put(
      "/auth/v1/user",
      data: {"password": password},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  @override
  Future<UserEntity> updateUser({required UserEntity user, required String accessToken}) async {
    final result = await client.put(
      "/auth/v1/user",
      data: user.toMap(),
      headers: {"Authorization": "Bearer $accessToken"},
    );
    return UserEntity.fromMap(result.data);
  }

  @override
  Future<bool> userExistsByEmail({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> userExistsByPhone({required PhoneNumber phoneNumber}) async {
    final response = await client.post(
      "/rest/v1/rpc/func_verify_user_exists_by_phone",
      data: {
        "phone": phoneNumber.fullPhoneOnlyNumbers(),
      },
    );
    return response.data;
  }

  @override
  Future<void> updatePasswordPhone({required PhoneNumber phoneNumber, required String encryptKey, required String accessToken}) async {
    await client.put(
      "/auth/v1/user",
      data: {
        "password": Encrypt.encodePasswordPhone(phoneNumber: phoneNumber, key: encryptKey),
      },
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
