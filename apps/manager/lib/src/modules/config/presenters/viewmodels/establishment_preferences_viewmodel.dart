import 'package:flutter/foundation.dart';
import 'package:core/core.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/establishment_preferences_store.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class EstablishmentPreferencesViewmodel {
  final UpdateEstablishmentUsecase updateEstablishmentUsecase;
  final IEstablishmentPreferencesRepository establishmentPreferencesRepo;
  final EstablishmentPreferencesStore establishmentPreferencesNotifier;
  EstablishmentPreferencesViewmodel({
    required this.updateEstablishmentUsecase,
    required this.establishmentPreferencesNotifier,
    required this.establishmentPreferencesRepo,
  });

  EstablishmentPreferencesEntity? _preferences;

  EstablishmentPreferencesEntity? get prefences => _preferences;

  bool _updateOrderNumber = false;

  void initalizeEstablishment(EstablishmentModel establishment) {
    _preferences = establishmentPreferencesNotifier.establishmentPreference.copyWith();
  }

  void edit(EstablishmentPreferencesEntity prefs) {
    _preferences = prefs;
  }

  Future<void> save() async {
    establishmentPreferencesNotifier.set(_preferences!);
    await establishmentPreferencesRepo.upsert(establishmentPreferences: _preferences!);
    if (_updateOrderNumber) {
      establishmentProvider.value = establishmentProvider.value.copyWith(currentOrderNumber: _preferences!.resetOrderNumberReference);
      await updateEstablishmentUsecase.call();
    }
  }

  void setResetOrderNumberPeriod(ResetOrderNumberPeriod period) {
    _updateOrderNumber = true;
    final date = nextDateResetOrder(period: period);
    _preferences = _preferences!.copyWith(resetOrderNumberPeriod: period, resetOrderNumberAt: date);
  }

  DateTime nextDateResetOrder({required ResetOrderNumberPeriod period, DateTime? now}) {
    final now_ = (now ?? DateTime.now()).copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

    final date = switch (period) {
      ResetOrderNumberPeriod.never => now_.copyWith(year: 9050),
      ResetOrderNumberPeriod.daily => now_.add(1.days),
      ResetOrderNumberPeriod.weekly => nextMondayDate(now: now_),
      ResetOrderNumberPeriod.monthly => now_.copyWith(day: 1, month: (now_.month != 12) ? now_.month + 1 : 1, year: (now_.month == 12) ? now_.year + 1 : now_.year),
      ResetOrderNumberPeriod.yearly => now_.copyWith(year: now_.year + 1, month: 1, day: 1),
    };

    return date;
  }

  @visibleForTesting
  DateTime nextMondayDate({required DateTime now}) {
    final daysUntilMonday = (now.weekday == DateTime.monday) ? 7 : (8 - now.weekday) % 7;

    final nextMonday = now.add(Duration(days: daysUntilMonday));

    return DateTime(
      nextMonday.year,
      nextMonday.month,
      nextMonday.day,
    );
  }
}
