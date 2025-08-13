import 'package:core/core.dart';
import 'package:core/src/views/establishment_menu_view.dart';
import 'package:test/test.dart';

void main() {
  late IClient client;

  late ViewsApi api;

  setUp(() async {
    await EnvTest.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: TestBaseOptions.supabase);
    api = ViewsApi(client: client);
  });

  // Arrange

  const String orderId = '33941faa-3473-407d-85bb-aa3141f2da87';
  const String paymentProviderId = '38058325-cec6-4e4a-b33b-443e719d9d0c';

  test('GET ORDER SPLIT WITH PAYMENT PROVIDER VIEW', () async {
    //Arrange

    //Act
    final result = await api.getOrderSplitWithpaymentProviderView(orderId: orderId);
    //Assert
    expect(result, isA<OrderSplitWithPaymentProviderView>());
  });
  test('GET PAYMENT PROVIDER VIEW', () async {
    //Arrange

    //Act
    final result = await api.getPaymentProviderView(id: paymentProviderId);
    //Assert
    expect(result, isA<PaymentProviderView>());
  });
  test('GET ORDER VIEW', () async {
    //Arrange

    //Act
    final result = await api.getOrderViewMap(orderId: '0b90b15e-2934-4acc-b662-0e4e3d0957fa');
    //Assert
    expect(result, isA<Map<String, dynamic>>());
  });

  test('GET ESTABLISHMENT MENU VIEW', () async {
    //Arrange

    //Act
    final result = await api.getEstablishmentMenuView(establishmentId: '7e92e0e7-4a09-43d1-90e6-4a1e98a1cc03');
    //Assert
    expect(result, isA<EstablishmentMenuView>());
  });
}
