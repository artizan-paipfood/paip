import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/home/aplication/usecases/close_establishment_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ScheadulingEstavlishmentCloseUsecase {
  final EstablishmentRepository establishmentRepo;
  final DataSource dataSource;
  final CloseEstablishmentUsecase closeEstablishmentUsecase;

  ScheadulingEstavlishmentCloseUsecase({
    required this.establishmentRepo,
    required this.dataSource,
    required this.closeEstablishmentUsecase,
  });
  void call() async {
    final now = DateTime.now();
    final List<OpeningHoursModel> openingHours = dataSource.openingHours.where((element) => element.weekDayId.id == now.weekday).toList();
    for (OpeningHoursModel result in openingHours) {
      result.closingDate = DateTime(now.year, now.month, now.day, result.closingDate.hour, result.closingDate.minute, result.closingDate.second);
    }
    final hour = openingHours.firstWhereOrNull((element) => element.closingDate.isAfter(now));
    if (hour != null) {
      final schedulingInMilisecond = hour.closingDate.difference(now).inMilliseconds;
      Future.delayed(schedulingInMilisecond.milliseconds + 1.minutes, () => closeEstablishmentUsecase.call());
    }
  }
}
