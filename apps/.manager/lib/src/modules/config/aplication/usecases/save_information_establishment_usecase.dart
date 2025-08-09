import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SaveInformationEstablishmentUsecase {
  final DataSource dataSource;
  final EstablishmentRepository establishmentRepo;
  final AddressApi addressRepo;
  SaveInformationEstablishmentUsecase({
    required this.dataSource,
    required this.establishmentRepo,
    required this.addressRepo,
  });
  Future<void> call() async {
    await Future.wait([
      establishmentRepo.updateEstablishment(establishment: establishmentProvider.value, authToken: AuthNotifier.instance.accessToken),
      addressRepo.upsert(address: establishmentProvider.value.address!, auth: AuthNotifier.instance.auth),
      establishmentRepo.updateCompany(company: dataSource.company, auth: AuthNotifier.instance.auth)
    ]);
  }
}
