import 'dart:async';
import 'package:manager/src/modules/config/sub_modules/payments/domain/usecases/payment_provider_stripe_usecase.dart';
import 'package:manager/src/modules/config/sub_modules/payments/domain/usecases/payment_provider_usecase.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/viewmodels/payments_viewmodel.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/viewmodels/stripe_card_component_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => EstablishmentRepository(http: i.get())),
        Bind.factory((i) => UpdateEstablishmentUsecase(establishmentRepo: i.get(), dataSource: i.get())),
        Bind.factory((i) => ViewsApi(client: i.get())),
        Bind.factory((i) => PaymentMethodRepository(http: i.get())),
        Bind.factory((i) => PaymentProviderApi(client: i.get())),
        Bind.factory((i) => PaymentProviderStripeApi(client: i.get())),
        Bind.factory(
          (i) => PaymentProviderStripeUsecase(
            paymentProviderApi: i.get(),
            viewsApi: i.get(),
            stripeApi: i.get(),
            paymentProviderStripeApi: i.get(),
          ),
        ),
        Bind.factory(
          (i) => StripeApi(client: ClientDio(baseOptions: HttpUtils.api())),
        ),
        Bind.singleton(
          (i) => PaymentsViewmodel(
            dataSource: i.get(),
            paymentMethodRepo: i.get(),
            paymentProviderUsecase: i.get(),
            updateEstablishmentUsecase: i.get(),
          ),
        ),
        Bind.singleton(
          (i) => StripeCardComponentViewmodel(
            paymentProviderUsecase: i.get(),
            paymentProviderStripeUsecase: i.get(),
          ),
        ),
        Bind.factory(
          (i) => PaymentProviderUsecase(
            paymentProviderApi: i.get(),
            viewsApi: i.get(),
            paymentProviderStripeApi: i.get(),
            stripeApi: i.get(),
          ),
        ),
      ];
}
