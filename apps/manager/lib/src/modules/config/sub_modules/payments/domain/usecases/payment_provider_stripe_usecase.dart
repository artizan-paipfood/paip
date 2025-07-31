import 'package:core/core.dart';
import 'package:manager/src/modules/config/sub_modules/payments/domain/dtos/create_account_stripe_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentProviderStripeUsecase {
  final PaymentProviderApi paymentProviderApi;
  final ViewsApi viewsApi;
  final StripeApi stripeApi;
  final PaymentProviderStripeApi paymentProviderStripeApi;
  PaymentProviderStripeUsecase({
    required this.paymentProviderApi,
    required this.viewsApi,
    required this.stripeApi,
    required this.paymentProviderStripeApi,
  });

  Future<PaymentProviderStripeEntity> create({required PaymentProviderStripeEntity stripe}) async {
    return (await paymentProviderStripeApi.upsert(
      paymentProviders: [stripe],
      authToken: AuthNotifier.instance.auth.accessToken!,
    ))
        .first;
  }

  Future<String> getLinkAccount({required String accountId}) async {
    return await stripeApi.buildAccountLink(accountId: accountId, country: LocaleNotifier.instance.locale.name);
  }

  Future<CreateAccountStripeDto> createAccount({required String paymentProviderId}) async {
    final result = await stripeApi.createAccount(country: LocaleNotifier.instance.locale.name);
    final stripe = PaymentProviderStripeEntity(
      accountId: result.accountId,
      paymentProviderId: paymentProviderId,
    );
    final stripeResult = (await paymentProviderStripeApi.upsert(
      paymentProviders: [stripe],
      authToken: AuthNotifier.instance.auth.accessToken!,
    ))
        .first;
    return CreateAccountStripeDto(stripe: stripeResult, url: result.link);
  }

  Future<PaymentProviderStripeEntity> verifyStatus({required PaymentProviderStripeEntity stripe}) async {
    final accountStatus = await stripeApi.accountStatus(accountId: stripe.accountId, country: LocaleNotifier.instance.locale.name);
    final status = accountStatus.chargesEnabled ? PaymentProviderAccountStatus.enable : PaymentProviderAccountStatus.pending;
    if (status != stripe.status && stripe.status != PaymentProviderAccountStatus.disable) {
      return (await paymentProviderStripeApi.upsert(paymentProviders: [stripe.copyWith(status: status)], authToken: AuthNotifier.instance.auth.accessToken!)).first;
    }
    return stripe;
  }
}
