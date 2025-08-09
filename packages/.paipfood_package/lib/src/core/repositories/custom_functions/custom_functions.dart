import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CustomFunctionsRepository implements ICustomFunctionsRepository {
  final IClient http;
  CustomFunctionsRepository({
    required this.http,
  });

  double pixTax(double value) {
    double tax = value * 0.01; // Calcula a taxa de 1%
    tax = (tax * 100).roundToDouble(); // Multiplica por 100 para mover duas casas decimais para a direita e arredonda
    tax = tax / 100; // Divide por 100 para voltar às duas casas decimais
    return tax;
  }

  @override
  Future<PaymentProviderInvoiceModel> generatePixSplit({required double value, required EstablishmentModel establishment, required String userId, String? title}) async {
    if (value <= 0) throw "O valor deve ser maior que zero";
    final request = await http.post('/func_generate_pix_split', data: {
      "p_json": {
        "establishment_id": establishment.id,
        "body": {
          "transaction_amount": value,
          "description": title,
          "payment_method_id": "pix",
          "payer": {
            "email": "eduardohr.muniz@outlook.com",
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
      }
    });

    return PaymentProviderInvoiceModel.fromMercadoPagoPix(request.data);

    // return orderInvoice.copyWith(
    //   amount: value - (pixTax(value) * 2),
    //   establishmentId: establishment.id,
    //   tax: pixTax(value) * 2,
    //   value: value,
    //   userId: userId,
    // );
  }

  @override
  Future<void> refoundPayment({required String paymentId, required double value, required EstablishmentModel establishment}) async {
    await http.post('/func_refound_pix', data: {
      "p_json": {
        "body": {
          "amount": value,
        },
        "establishment_id": establishment.id,
        "payment_id": paymentId
      }
    });
  }

  @override
  Future<PaymentProviderInvoiceModel> generatePixEstablishmentInvoice({required double value, required EstablishmentModel establishment}) async {
    final request = await http.post('/func_generate_pix', data: {
      "p_json": {
        "establishment_id": establishment.id,
        "body": {
          "transaction_amount": value,
          "description": establishment.fantasyName,
          "payment_method_id": "pix",
          "payer": {
            "email": "eduardohr.muniz@outlook.com",
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
        },
      }
    });
    return PaymentProviderInvoiceModel.fromMercadoPagoPix(request.data);
  }
}
