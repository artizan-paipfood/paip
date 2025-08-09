import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class InsertUserCompanyEstablishmentUsecase {
  final IAddressApi addressRepo;
  final IAuthRepository authRepo;
  final IEstablishmentRepository establishmentRepo;
  final ImportDeliveryAreasByCityUsecase importDeliveryAreasByCityUsecase;
  final IPaymentMethodRepository paymentMethodRepo;
  final IDeliveryAreasPerMileRepository deliveryAreasPerMileRepo;
  InsertUserCompanyEstablishmentUsecase({required this.addressRepo, required this.authRepo, required this.establishmentRepo, required this.paymentMethodRepo, required this.importDeliveryAreasByCityUsecase, required this.deliveryAreasPerMileRepo});
  Future<void> call({required UserModel user, required String password, required CompanyModel company, required AddressEntity address, required EstablishmentModel establishment}) async {
    final cityAndCountry = await addressRepo.getByCityAndCountry(address.city, address.country);
    establishment = establishment.copyWith(city: cityAndCountry.city, locale: LocaleNotifier.instance.locale);
    AuthModel auth = await authRepo.signUpByEmail(email: user.email!, password: password);
    company = company.copyWith(userAdminId: auth.user!.id);
    final company_ = await establishmentRepo.insertCompany(company: company, auth: auth);
    auth = auth.copyWith(user: user.copyWith(companySlug: company.slug, id: auth.user!.id));
    await authRepo.updateUser(auth: auth);
    await establishmentRepo.insertEstablishment(establishment: establishment, auth: auth, companySlug: company_.slug);
    address = address.copyWith(establishmentId: company.establishments.first.id);
    await paymentMethodRepo.upsert(paymentMethod: PaymentMethodModel(establishmentId: establishment.id), auth: auth);
    final addressResult = await addressRepo.upsert(address: address, auth: AuthNotifier.instance.auth);
    await establishmentRepo.updateEstablishment(establishment: company.establishments.first.copyWith(city: addressResult.city), authToken: auth.accessToken!);
    await importDeliveryAreasByCityUsecase.call(city: cityAndCountry.city, establishmentId: establishment.id);
  }
}
