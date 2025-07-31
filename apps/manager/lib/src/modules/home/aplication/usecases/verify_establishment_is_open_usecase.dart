import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class VerifyEstablishmentIsOpenUsecase {
  final EstablishmentRepository establishmentRepo;
  final DataSource dataSource;

  VerifyEstablishmentIsOpenUsecase({required this.establishmentRepo, required this.dataSource});
  bool call() {
    final now = DateTime.now();
    final List<OpeningHoursModel> openingHours = dataSource.openingHours.where((element) => element.weekDayId.id == now.weekday).toList();
    for (OpeningHoursModel result in openingHours) {
      result.closingDate = DateTime(now.year, now.month, now.day, result.closingDate.hour, result.closingDate.minute, result.closingDate.second);
    }
    final isOpen = openingHours.firstWhereOrNull((element) => element.closingDate.isAfter(now));
    return isOpen != null;
  }
}
