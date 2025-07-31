import 'package:core/core.dart';

class ViewsApi {
  final IClient client;

  ViewsApi({
    required this.client,
  });

  Future<OrderSplitWithPaymentProviderView> getOrderSplitWithpaymentProviderView({
    required String orderId,
  }) async {
    final response = await client.get(
      '/rest/v1/${OrderSplitWithPaymentProviderView.view}?id=eq.$orderId&select=*&limit=1',
    );
    final List list = response.data;
    return OrderSplitWithPaymentProviderView.fromMap(
      list.first,
    );
  }

  Future<PaymentProviderView?> getPaymentProviderView({
    required String id,
  }) async {
    final response = await client.get(
      '/rest/v1/${PaymentProviderView.view}?id=eq.$id&select=*&limit=1',
    );
    final List list = response.data;
    if (list.isEmpty) {
      return null;
    }
    return PaymentProviderView.fromMap(
      list.first,
    );
  }

  Future<Map<String, dynamic>> getOrderViewMap({
    required String orderId,
  }) async {
    final response = await client.get(
      '/rest/v1/view_orders?id=eq.$orderId&select=*&limit=1',
    );
    final List list = response.data;
    return list.first;
  }
}
