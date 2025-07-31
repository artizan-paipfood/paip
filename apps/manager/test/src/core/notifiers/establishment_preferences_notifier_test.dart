import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:manager/src/core/stores/establishment_preferences_store.dart';

void main() {
  group('ESTABLISHMENT PREFERENCES NOTIFIER', () {
    late EstablishmentPreferencesStore notifier;

    setUp(() {
      notifier = EstablishmentPreferencesStore.instance;
    });

    test('set() deve atualizar as preferências do estabelecimento', () {
      final preferences = EstablishmentPreferencesEntity(
        establishmentId: 'est-id',
        resetOrderNumberPeriod: ResetOrderNumberPeriod.never,
        resetOrderNumberAt: DateTime.now(),
      );

      notifier.set(preferences);

      expect(notifier.establishmentPreference, preferences);
    });

    test('establishmentPreference deve retornar as preferências padrão quando não houver preferências definidas', () {
      final defaultPreferences = notifier.establishmentPreference;

      expect(defaultPreferences.establishmentId, isNotEmpty);
      expect(defaultPreferences.resetOrderNumberPeriod, ResetOrderNumberPeriod.never);
      expect(defaultPreferences.resetOrderNumberAt, isNotNull);
    });

    test('set() deve notificar os listeners quando as preferências são atualizadas', () {
      var notified = false;
      notifier.listener.addListener(() {
        notified = true;
      });

      final preferences = EstablishmentPreferencesEntity(
        establishmentId: 'est-id',
        resetOrderNumberPeriod: ResetOrderNumberPeriod.daily,
        resetOrderNumberAt: DateTime.now(),
      );

      notifier.set(preferences);

      expect(notified, true);
    });
  });
}
