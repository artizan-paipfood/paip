import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/establishment_preferences_store.dart';
import 'package:manager/src/core/stores/layout_printer_store.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/establishment_preferences_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LoadEstablishmentsByCompanyUsecase {
  final DataSource dataSource;
  final EstablishmentRepository establishmentRepo;
  final AddressRepository addressRepo;
  final IDeliveryAreasPerMileRepository deliveryAreasPerMileRepo;
  final LayoutPrinterApi layoutPrinterApi;
  final EstablishmentUsecase establishmentUsecase;
  final EstablishmentPreferencesViewmodel establishmentPreferencesViewmodel;
  final IEstablishmentPreferencesRepository establishmentPreferencesRepo;
  final EstablishmentPreferencesStore establishmentPreferencesNotifier;
  final IOpeningHoursRepository openingHoursRepo;
  LoadEstablishmentsByCompanyUsecase({
    required this.dataSource,
    required this.establishmentRepo,
    required this.addressRepo,
    required this.deliveryAreasPerMileRepo,
    required this.layoutPrinterApi,
    required this.establishmentUsecase,
    required this.establishmentPreferencesViewmodel,
    required this.establishmentPreferencesRepo,
    required this.establishmentPreferencesNotifier,
    required this.openingHoursRepo,
  });
  Future<void> call() async {
    final shortEstablishments = await establishmentRepo.getShortEstablishmentsBySlug(AuthNotifier.instance.auth.user!.companySlug!);
    final establishment = await establishmentRepo.getDataEstablishmentById(shortEstablishments.first.id);
    LocaleNotifier.instance.setLocale(establishment.locale);
    dataSource.company = (await establishmentRepo.getCompanyBySlug(AuthNotifier.instance.auth.user!.companySlug!))!;
    dataSource.establishments.add(establishment);
    establishmentProvider.value = establishment;
    final address = await addressRepo.getByEstablishmentId(establishmentProvider.value.id);
    final layoutPrinters = await layoutPrinterApi.getByEstablishmentId(id: establishmentProvider.value.id);
    LayoutPrinterStore.instance.reload(layouts: layoutPrinters.map((layout) => LayoutPrinterDto.fromLayoutPrinterEnity(layout)).toList());
    final openingHours = await openingHoursRepo.getByEstablishmentId(establishment.id);
    establishmentProvider.value = establishmentProvider.value.copyWith(address: address);
    dataSource.openingHours = openingHours;
    final deliveryAreasPerMile = await deliveryAreasPerMileRepo.getByEstablishmentId(establishment.id);
    // TODO:@eduardo Implementar o store
    // DeliveryAreaPerMileStore.instance.setDeliveryAreaPerMile(deliveryAreasPerMile);
    // preferences
    final establishmentPreferences = await _getEstablishmentPreferences(establishment.id);
    establishmentPreferencesNotifier.set(establishmentPreferences);
    final newCurrentOrderNumber = await _verifyResetOrderNumber(establishmentPreferences);
    if (newCurrentOrderNumber != null) {
      await establishmentRepo.updateEstablishment(establishment: establishment.copyWith(currentOrderNumber: newCurrentOrderNumber), authToken: AuthNotifier.instance.auth.accessToken!);
      establishmentProvider.value = establishmentProvider.value.copyWith(currentOrderNumber: newCurrentOrderNumber);
    }
  }

  Future<EstablishmentPreferencesEntity> _getEstablishmentPreferences(String establishmentId) async {
    try {
      return await establishmentPreferencesRepo.getById(establishmentId: establishmentId);
    } catch (_) {
      return EstablishmentPreferencesEntity(establishmentId: establishmentId);
    }
  }

  Future<int?> _verifyResetOrderNumber(EstablishmentPreferencesEntity establishmentPreferences) async {
    if (establishmentPreferences.needResetOrderNumber()) {
      final result = establishmentPreferences.copyWith(
        resetOrderNumberAt: establishmentPreferencesViewmodel.nextDateResetOrder(
          period: establishmentPreferences.resetOrderNumberPeriod,
          now: DateTime.now(),
        ),
      );
      await establishmentPreferencesRepo.upsert(establishmentPreferences: result);
      return result.resetOrderNumberReference;
    }
    return null;
  }
}
