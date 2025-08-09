import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UpdateEstablishmentUsecase {
  final EstablishmentRepository establishmentRepo;
  final DataSource dataSource;
  UpdateEstablishmentUsecase({
    required this.establishmentRepo,
    required this.dataSource,
  });
  Future<void> call() async {
    await establishmentRepo.updateEstablishment(establishment: establishmentProvider.value, authToken: AuthNotifier.instance.accessToken);
  }
}
