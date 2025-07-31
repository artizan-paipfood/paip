import 'dart:async';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/auth/data/usecases/load_establishments_by_company_usecase.dart';

import 'package:manager/src/modules/driver/aplication/usecases/load_driver_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AuthService {
  final AuthRepository authRepo;
  final LoadEstablishmentsByCompanyUsecase getEstablishmentsByCompanyUsecase;

  final DataSource dataSource;
  final LoadDriverUsecase loadDeliveryMenUsecase;

  AuthService({
    required this.authRepo,
    required this.getEstablishmentsByCompanyUsecase,
    required this.dataSource,
    required this.loadDeliveryMenUsecase,
  });

  Future<bool> checkLoggedIn() async {
    await AuthNotifier.instance.initialize(EmailRefreshTokenService(authRepository: authRepo));
    await Future.delayed(2.seconds);
    try {
      final auth = await AuthNotifier.instance.refreshToken();
      if (auth == null) return false;
      await _load(auth);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    final auth = await authRepo.loginByEmail(email: email, password: password);
    await _load(auth);

    await Future.delayed(1.seconds);
  }

  Future<void> _load(AuthModel auth) async {
    await AuthNotifier.instance.login(auth);
    await getEstablishmentsByCompanyUsecase.call();
    await loadDeliveryMenUsecase.call(establishmentId: establishmentProvider.value.id);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await authRepo.forgotPassword(email: email);
  }
}
