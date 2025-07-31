import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:manager/src/core/stores/establishment_preferences_store.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/establishment_preferences_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UpdateEstablishmentUsecaseMock extends Mock implements UpdateEstablishmentUsecase {}

class EstablishmentPreferencesNotifierMock extends Mock implements EstablishmentPreferencesStore {}

class IEstablishmentPreferencesRepositoryMock extends Mock implements IEstablishmentPreferencesRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      EstablishmentPreferencesEntity(
        establishmentId: 'dummy-id',
        resetOrderNumberPeriod: ResetOrderNumberPeriod.never,
        resetOrderNumberAt: DateTime.now(),
      ),
    );
  });

  group('ESTABLISHMENT PREFERENCES VIEWMODEL', () {
    late UpdateEstablishmentUsecaseMock updateEstablishmentUsecaseMock;
    late EstablishmentPreferencesNotifierMock establishmentPreferencesNotifierMock;
    late IEstablishmentPreferencesRepositoryMock establishmentPreferencesRepoMock;
    late EstablishmentPreferencesViewmodel viewmodel;

    setUp(() {
      updateEstablishmentUsecaseMock = UpdateEstablishmentUsecaseMock();
      establishmentPreferencesNotifierMock = EstablishmentPreferencesNotifierMock();
      establishmentPreferencesRepoMock = IEstablishmentPreferencesRepositoryMock();
      viewmodel = EstablishmentPreferencesViewmodel(
        updateEstablishmentUsecase: updateEstablishmentUsecaseMock,
        establishmentPreferencesNotifier: establishmentPreferencesNotifierMock,
        establishmentPreferencesRepo: establishmentPreferencesRepoMock,
      );
    });

    test('initalizeEstablishment() Deve inicializar a viewmodel com as preferências do estabelecimento.', () {
      final establishment = EstablishmentModel(id: 'abc', companySlug: 'abc');
      final preferences = EstablishmentPreferencesEntity(
        establishmentId: 'est-id',
        resetOrderNumberPeriod: ResetOrderNumberPeriod.never,
        resetOrderNumberAt: DateTime.now(),
      );

      when(() => establishmentPreferencesNotifierMock.establishmentPreference).thenReturn(preferences);

      viewmodel.initalizeEstablishment(establishment);
      expect(viewmodel.prefences, isNotNull);
      expect(viewmodel.prefences?.establishmentId, preferences.establishmentId);
    });

    test('edit() Deve editar as preferências do estabelecimento.', () {
      final establishment = EstablishmentModel(id: 'abc', companySlug: 'abc');
      final preferences = EstablishmentPreferencesEntity(
        establishmentId: 'est-id',
        resetOrderNumberPeriod: ResetOrderNumberPeriod.never,
        resetOrderNumberAt: DateTime.now(),
      );

      when(() => establishmentPreferencesNotifierMock.establishmentPreference).thenReturn(preferences);

      viewmodel
        ..initalizeEstablishment(establishment)
        ..edit(preferences.copyWith(resetOrderNumberPeriod: ResetOrderNumberPeriod.daily));
      expect(viewmodel.prefences?.resetOrderNumberPeriod, ResetOrderNumberPeriod.daily);
    });

    test('save() Deve salvar as alterações e atualizar o número do pedido quando necessário', () async {
      final preferences = EstablishmentPreferencesEntity(
        establishmentId: 'est-id',
        resetOrderNumberPeriod: ResetOrderNumberPeriod.never,
        resetOrderNumberAt: DateTime.now(),
        resetOrderNumberReference: 100,
      );

      when(() => updateEstablishmentUsecaseMock.call()).thenAnswer((_) async {});
      when(() => establishmentPreferencesRepoMock.upsert(establishmentPreferences: any(named: 'establishmentPreferences'))).thenAnswer((_) async => preferences);
      when(() => establishmentPreferencesNotifierMock.establishmentPreference).thenReturn(preferences);

      viewmodel
        ..initalizeEstablishment(EstablishmentModel(id: 'abc', companySlug: 'abc'))
        ..edit(preferences.copyWith(resetOrderNumberPeriod: ResetOrderNumberPeriod.daily))
        ..setResetOrderNumberPeriod(ResetOrderNumberPeriod.daily);
      await viewmodel.save();

      verify(() => establishmentPreferencesNotifierMock.set(any())).called(1);
      verify(() => establishmentPreferencesRepoMock.upsert(establishmentPreferences: any(named: 'establishmentPreferences'))).called(1);
      verify(() => updateEstablishmentUsecaseMock.call()).called(1);
    });

    test('save() Deve salvar as alterações sem atualizar o número do pedido quando não necessário', () async {
      final preferences = EstablishmentPreferencesEntity(
        establishmentId: 'est-id',
        resetOrderNumberPeriod: ResetOrderNumberPeriod.never,
        resetOrderNumberAt: DateTime.now(),
      );

      when(() => establishmentPreferencesRepoMock.upsert(establishmentPreferences: any(named: 'establishmentPreferences'))).thenAnswer((_) async => preferences);
      when(() => establishmentPreferencesNotifierMock.establishmentPreference).thenReturn(preferences);

      viewmodel
        ..initalizeEstablishment(EstablishmentModel(id: 'abc', companySlug: 'abc'))
        ..edit(preferences.copyWith(resetOrderNumberPeriod: ResetOrderNumberPeriod.daily));
      await viewmodel.save();

      verify(() => establishmentPreferencesNotifierMock.set(any())).called(1);
      verify(() => establishmentPreferencesRepoMock.upsert(establishmentPreferences: any(named: 'establishmentPreferences'))).called(1);
      verifyNever(() => updateEstablishmentUsecaseMock.call());
    });

    test('setResetOrderNumberPeriod() Deve setar o periodo de reset do pedido e alterar a data para o próximo reset', () {
      final now = DateTime.now();
      final preferences = EstablishmentPreferencesEntity(
        establishmentId: 'est-id',
        resetOrderNumberPeriod: ResetOrderNumberPeriod.never,
        resetOrderNumberAt: now,
      );

      when(() => establishmentPreferencesNotifierMock.establishmentPreference).thenReturn(preferences);

      viewmodel
        ..initalizeEstablishment(EstablishmentModel(id: 'abc', companySlug: 'abc'))
        ..setResetOrderNumberPeriod(ResetOrderNumberPeriod.monthly);

      expect(viewmodel.prefences?.resetOrderNumberPeriod, ResetOrderNumberPeriod.monthly);
      expect(viewmodel.prefences?.resetOrderNumberAt, isNot(now));
    });

    group('nextMondayDate()', () {
      test('Deve retornar a próxima segunda-feira (Início de mês)', () {
        final now = DateTime(2025, 4).copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
        final segunda = now.copyWith(day: 7);
        final terca = now.copyWith(day: 8);
        final quarta = now.copyWith(day: 9);
        final quinta = now.copyWith(day: 10);
        final sexta = now.copyWith(day: 11);
        final sabado = now.copyWith(day: 12);
        final domingo = now.copyWith(day: 13);
        final proximaSegunda = now.copyWith(day: 14);

        expect(viewmodel.nextMondayDate(now: segunda).day, proximaSegunda.day);
        expect(viewmodel.nextMondayDate(now: terca).day, proximaSegunda.day);
        expect(viewmodel.nextMondayDate(now: quarta).day, proximaSegunda.day);
        expect(viewmodel.nextMondayDate(now: quinta).day, proximaSegunda.day);
        expect(viewmodel.nextMondayDate(now: sexta).day, proximaSegunda.day);
        expect(viewmodel.nextMondayDate(now: sabado).day, proximaSegunda.day);
        expect(viewmodel.nextMondayDate(now: domingo).day, proximaSegunda.day);
      });

      test('Deve retornar a próxima segunda-feira (Fim de mês)', () {
        final now = DateTime(2025, 4).copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
        final domingo = now.copyWith(day: 27);
        final segunda = now.copyWith(day: 28);
        final terca = now.copyWith(day: 29);
        final quarta = now.copyWith(day: 30);

        final proximaSegunda = now.copyWith(day: 5);

        expect(viewmodel.nextMondayDate(now: domingo).day, segunda.day);
        expect(viewmodel.nextMondayDate(now: segunda).day, proximaSegunda.day);
        expect(viewmodel.nextMondayDate(now: terca).day, proximaSegunda.day);
        expect(viewmodel.nextMondayDate(now: quarta).day, proximaSegunda.day);
      });
    });

    group('nextDateResetOrder()', () {
      test('ResetOrderNumber.never deve retornar o ano 9050', () {
        final result = viewmodel.nextDateResetOrder(period: ResetOrderNumberPeriod.never);
        expect(result.year, 9050);
      });

      test('ResetOrderNumber.daily deve retornar o dia seguinte', () {
        final now = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
        final result = viewmodel.nextDateResetOrder(period: ResetOrderNumberPeriod.daily);
        expect(result, now.add(const Duration(days: 1)));
      });

      test('ResetOrderNumber.weekly deve retornar a próxima segunda-feira (Início de mês)', () {
        final now = DateTime(2025, 4).copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
        final segunda = now.copyWith(day: 7);
        final terca = now.copyWith(day: 8);
        final proximaSegunda = now.copyWith(day: 14);

        expect(viewmodel.nextDateResetOrder(period: ResetOrderNumberPeriod.weekly, now: segunda).day, proximaSegunda.day);
        expect(viewmodel.nextDateResetOrder(period: ResetOrderNumberPeriod.weekly, now: terca).day, proximaSegunda.day);
      });

      test('ResetOrderNumber.weekly se for a última semana do mês deve retornar a segunda-feira da próxima semana (Fim de mês)', () {
        final now = DateTime(2025, 4).copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
        final domingo = now.copyWith(day: 27);
        final segunda = now.copyWith(day: 28);
        final proximaSegunda = now.copyWith(day: 5);

        expect(viewmodel.nextDateResetOrder(period: ResetOrderNumberPeriod.weekly, now: domingo).day, segunda.day);
        expect(viewmodel.nextDateResetOrder(period: ResetOrderNumberPeriod.weekly, now: segunda).day, proximaSegunda.day);
      });

      test('ResetOrderNumber.monthly não sendo dezembro deve retornar o dia 1 do mês seguinte', () {
        final now = DateTime.now().copyWith(month: 11, hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
        final result = viewmodel.nextDateResetOrder(period: ResetOrderNumberPeriod.monthly, now: now);
        expect(now.copyWith(month: 12, day: 1), result);
      });

      test('ResetOrderNumber.monthly sendo dezembro deve retornar o dia 1 do mês 1 do ano seguinte', () {
        final now = DateTime.now().copyWith(month: 12, hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
        final result = viewmodel.nextDateResetOrder(period: ResetOrderNumberPeriod.monthly, now: now);
        expect(now.copyWith(month: 1, day: 1, year: now.year + 1), result);
      });

      test('ResetOrderNumber.yearly deve retornar o dia 1 do mês 1 do ano seguinte', () {
        final now = DateTime.now();
        final result = viewmodel.nextDateResetOrder(period: ResetOrderNumberPeriod.yearly);
        expect(result.year, now.year + 1);
        expect(result.month, 1);
        expect(result.day, 1);
      });
    });
  });
}
