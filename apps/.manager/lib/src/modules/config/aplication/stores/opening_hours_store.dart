import 'package:flutter/widgets.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OpeningStore extends ChangeNotifier {
  final DataSource dataSource;
  final IOpeningHoursRepository openingHoursRepo;
  final UpdateEstablishmentUsecase updateEstablishmentUsecase;
  OpeningStore({required this.dataSource, required this.openingHoursRepo, required this.updateEstablishmentUsecase});

  List<OpeningHoursModel> get openingHours => dataSource.openingHours;

  EstablishmentModel get establishment => establishmentProvider.value;

  Future<void> save({required List<WeekDayEnum> weekDays, required HoursEnum opening, required HoursEnum closing}) async {
    final List<OpeningHoursModel> results = [];

    for (var weekDay in weekDays) {
      final bool hasOverlap = openingHours.where((dataSource) => weekDay == dataSource.weekDayId).toList().any(
            (r) =>
                opening.value.isInRange(min: r.openingEnumValue.value, max: r.closingEnumValue.value) ||
                closing.value.isInRange(min: r.openingEnumValue.value, max: r.closingEnumValue.value) ||
                r.openingEnumValue.value.isInRange(min: opening.value, max: closing.value) ||
                r.closingEnumValue.value.isInRange(min: opening.value, max: closing.value),
          );

      if (hasOverlap) {
        toast.showError(l10nProiver.conflitoHorarioDiaSemana(weekDay.label.toUpperCase()));
        continue;
      }
      results.add(OpeningHoursModel(id: uuid, establishmentId: establishmentProvider.value.id, weekDayId: weekDay, openningDate: opening.dateTime, closingDate: closing.dateTime, openingEnumValue: opening, closingEnumValue: closing));
    }
    final result = await openingHoursRepo.upsert(openingHours: results, auth: AuthNotifier.instance.auth);
    dataSource.openingHours.addAll(result);
    notifyListeners();
  }

  Future<void> delete(OpeningHoursModel model) async {
    dataSource.openingHours.remove(model);
    await openingHoursRepo.delete(id: model.id, auth: AuthNotifier.instance.auth);
    notifyListeners();
  }

  Future<void> updateEstablishment(EstablishmentModel establishment) async {
    establishmentProvider.value = establishment;
    await updateEstablishmentUsecase.call();
  }

  Future<void> update({required OpeningHoursModel model, required HoursEnum opening, required HoursEnum closing}) async {
    final bool hasOverlap = openingHours.where((dataSource) => model.weekDayId == dataSource.weekDayId && dataSource.id != model.id).toList().any(
          (r) =>
              opening.value.isInRange(min: r.openingEnumValue.value, max: r.closingEnumValue.value) ||
              closing.value.isInRange(min: r.openingEnumValue.value, max: r.closingEnumValue.value) ||
              r.openingEnumValue.value.isInRange(min: opening.value, max: closing.value) ||
              r.closingEnumValue.value.isInRange(min: opening.value, max: closing.value),
        );
    if (hasOverlap) throw l10nProiver.conflitoHorarioDiaSemana(model.weekDayId.label.toUpperCase());
    model = model.copyWith(openningDate: opening.dateTime, closingDate: closing.dateTime, openingEnumValue: opening, closingEnumValue: closing);

    await openingHoursRepo.upsert(openingHours: [model], auth: AuthNotifier.instance.auth);
    dataSource.openingHours.remove(dataSource.openingHours.firstWhere((element) => element.id == model.id));
    dataSource.openingHours.add(model);
    notifyListeners();
  }
}
