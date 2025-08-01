import 'package:app/src/core/data/data_source.dart';
import 'package:app/src/modules/menu/domain/models/data_establishment_dto.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class GetMenuByEstablishmentUsecase {
  final EstablishmentRepository establishmentRepository;
  final GetMenuHttpUsecase getMenuHttpUsecase;
  final BuildMenuFromMapUsecase getMenuVObjUsecase;
  final IOpeningHoursRepository openingHoursRepo;
  final DataSource dataSource;

  final IPaymentMethodRepository paymentMethodRepo;
  final IDeliveryAreasPerMileRepository deliveryAreasPerMileRepository;
  GetMenuByEstablishmentUsecase({required this.establishmentRepository, required this.getMenuHttpUsecase, required this.deliveryAreasPerMileRepository, required this.getMenuVObjUsecase, required this.openingHoursRepo, required this.dataSource, required this.paymentMethodRepo});
  Future<DataEstablishmentDto> call(String establishmentId) async {
    final paymentMethod = await paymentMethodRepo.getByEstablishmentId(establishmentId);
    final menuMap = await getMenuHttpUsecase.call(establishmentId: establishmentId, onlyVisible: true);
    final menuVObj = await getMenuVObjUsecase.call(menuMap);
    final openingHours = await openingHoursRepo.getByEstablishmentId(establishmentId);
    final establishment = await establishmentRepository.getDataEstablishmentById(establishmentId);
    DeliveryAreaPerMileEntity? deliveryAreaPerMileEntity;

    dataSource.paymentMethod = paymentMethod;
    LocaleNotifier.instance.setLocale(establishment.locale);
    LanguageNotifier.instance.change(LocaleNotifier.instance.locale.locale);
    return DataEstablishmentDto(establishment: establishment, menu: menuVObj, openingHours: openingHours, deliveryAreaPerMile: deliveryAreaPerMileEntity);
  }
}
