import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:paipfood_package/paipfood_package.dart';

class MercadoPagoRepository implements IMercadoPagoRepository {
  final IClient http;
  MercadoPagoRepository({
    required this.http,
  });

  static String get redirectUri => "https://portal.v2.paipfood.com/mercado_pago/";

  double pixTax(double value) {
    double tax = value * 0.01; // Calcula a taxa de 1%
    tax = (tax * 100).roundToDouble(); // Multiplica por 100 para mover duas casas decimais para a direita e arredonda
    tax = tax / 100; // Divide por 100 para voltar às duas casas decimais
    return tax;
  }

  @override
  Future<MercadoPagoModel> getToken(String code) async {
    final request =
        await http.post('oauth/token', headers: {"Content-Type": "application/x-www-form-urlencoded"}, data: {"client_id": Env.mercadoPagoClientId, "client_secret": Env.mercadoPagoClientSecret, "code": code, "grant_type": "authorization_code", "redirect_uri": redirectUri});

    return MercadoPagoModel.fromMap(request.data);
  }

  @override
  Uri getUrlConfig({required String establishmentId, required String userAccessToken}) {
    return Uri(
      scheme: "https",
      host: "auth.mercadopago.com.br",
      path: "/authorization",
      query: "client_id=${Env.mercadoPagoClientId}&response_type=code&state=$establishmentId|$userAccessToken&platform_id=mp&redirect_uri=$redirectUri",
    );
  }

  @override
  Future<MercadoPagoModel> refreshToken(String refreshToken) async {
    final request = await http.post(
      "oauth/token",
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      data: {"client_id": Env.mercadoPagoClientId, "client_secret": Env.mercadoPagoClientSecret, "refresh_token": refreshToken, "grant_type": "refresh_token", "redirect_uri": redirectUri},
    );

    return MercadoPagoModel.fromMap(request.data);
  }

  @override
  Future<List<String>> getPaymentMethods(String token) async {
    final request = await http.get(
      'payment_methods',
      headers: {'Authorization': 'Bearer $token'},
    );

    final List list = request.data;
    return list.map((e) => e['id']).toList() as List<String>;
  }

  @override
  Future<String> getPaymentStatus({required String token, required String paymentId}) async {
    final request = await http.get(
      'v1/payments/$paymentId',
      headers: {'Authorization': 'Bearer $token', 'X-Idempotency-Key': uuid},
    );
    return request.data['status'];
  }

  @override
  Future<void> refoundPayment({required String token, required String paymentId, required double value}) async {
    await http.post(
      'v1/payments/$paymentId/refunds',
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      data: {'amount': value},
    );
  }

  @override
  Future<PaymentProviderInvoiceModel> generatePix({
    required double value,
    required EstablishmentModel establishment,
    required String userId,
    String? title,
    String? email,
  }) async {
    if (value <= 0) throw "O valor deve ser maior que zero";
    final request = await http.post(
      'v1/payments',
      headers: {
        'Authorization': 'Bearer ',
        'X-Idempotency-Key': uuid,
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      data: {
        "transaction_amount": value,
        "description": title,
        "payment_method_id": "pix",
        "payer": {
          "email": establishment.email,
          "first_name": establishment.fantasyName,
          "last_name": establishment.fantasyName,
          "identification": {"type": "CPF", "number": Utils.onlyNumbersRgx(establishment.personalDocument)},
          "address": {
            "zip_code": establishment.address?.zipCode ?? "37704110",
            "street_name": establishment.address?.street ?? "Rua Ibirapuera",
            "street_number": establishment.address?.number ?? "183",
            "neighborhood": establishment.address?.neighborhood ?? "Dom bosco",
            "city": establishment.address?.city ?? "Pocos de caldas",
            "federal_unit": establishment.address?.state ?? "MG"
          }
        },
        "application_fee": pixTax(value),
      },
    );

    return PaymentProviderInvoiceModel.fromMercadoPagoPix(request.data);

    // return orderInvoice.copyWith(
    //   amount: value - (pixTax(value) * 2),
    //   establishmentId: establishment.id,
    //   tax: pixTax(value) * 2,
    //   value: value,
    //   userId: userId,
    // );
  }
}
