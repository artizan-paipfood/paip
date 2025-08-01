import 'package:app/src/modules/order/order/domain/dtos/order_and_establishment_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderUsecase {
  final IOrderRepository orderRepo;
  final IEstablishmentRepository establishmentRepo;
  final IAddressRepository addressRepo;

  OrderUsecase({
    required this.orderRepo,
    required this.establishmentRepo,
    required this.addressRepo,
  });

  Future<OrderModel> loadOrder(String orderId) async {
    final order = await orderRepo.get(orderId);
    return order;
  }

  Future<OrderAndEstablishmentDto> loadDto(String orderId) async {
    final order = await orderRepo.get(orderId);
    final establishment = await establishmentRepo.getDataEstablishmentById(order.establishmentId);
    final address = await addressRepo.getByEstablishmentId(order.establishmentId);
    return OrderAndEstablishmentDto(order: order, establishment: establishment!.copyWith(address: address));
  }
}
