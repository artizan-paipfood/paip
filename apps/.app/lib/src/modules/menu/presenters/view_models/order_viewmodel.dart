import 'package:flutter/material.dart';
import 'package:app/src/core/dtos/cache_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderViewmodel extends ChangeNotifier {
  final ILocalStorage localStorage;
  OrderViewmodel({required this.localStorage});
  OrderModel _order = OrderModel.empty();

  OrderModel get order => _order;

  void setOrder(OrderModel order) {
    _order = order;
    notifyListeners();
  }

  bool _cacheLoaded = false;

  void addProduct(CartProductDto cartProduct) {
    _order = _order.copyWith(cartProducts: [..._order.cartProducts, cartProduct]);
    _saveCache();
    notifyListeners();
  }

  void removeProduct(CartProductDto cartProduct) {
    _order = _order.copyWith(cartProducts: [..._order.cartProducts]..remove(cartProduct));
    _saveCache();
    notifyListeners();
  }

  void setEstablishmentId(String establishmentId) {
    _order = _order.copyWith(establishmentId: establishmentId);
    _saveCache();
    notifyListeners();
  }

  void changeOrderType(OrderTypeEnum orderType) {
    _order = _order.copyWith(orderType: orderType);
    _saveCache();
    notifyListeners();
  }

  void unsetShedule() {
    _order = _order.copyWith(scheduleDate: null);
    _saveCache();
    notifyListeners();
  }

  void setSchedule({required HoursEnum hour, required int weekDay}) {
    _order = _order.copyWith(scheduleDate: hour.buildDateByWeekDay(weekDay));
    _saveCache();
    notifyListeners();
  }

  int get qtyCartProduct => _order.cartProducts.fold(0, (previousValue, element) => previousValue + element.qty);

  double get getSubtotalMinusDiscounts {
    double total = (_order.getSubTotal - _order.discount);
    return total;
  }

  Future<void> _saveCache() async {
    await localStorage.put(
      PreferencesModel.box,
      key: OrderModel.box,
      value: CacheDto(
        data: _order.toMap(),
        expiresIn: DateTime.now().add(const Duration(minutes: 5)),
      ).toMap(),
    );
  }

  Future<void> deleteCache() async {
    _cacheLoaded = false;
    await localStorage.delete(PreferencesModel.box, keys: [OrderModel.box]);
  }

  Future<void> loadCache(String establishmentId) async {
    if (_cacheLoaded) return;
    _cacheLoaded = true;

    _order = _order.copyWith(establishmentId: establishmentId);
    final data = await localStorage.get(PreferencesModel.box, key: OrderModel.box);

    if (data == null) {
      _resetOrder(establishmentId);
      return;
    }

    final cache = CacheDto.fromMap(data);
    if (cache.isExpired) {
      await deleteCache();
      _resetOrder(establishmentId);
      return;
    }

    final loadedOrder = OrderModel.fromMap(cache.data);
    if (loadedOrder.establishmentId != establishmentId) {
      await deleteCache();
      _resetOrder(establishmentId);
    } else {
      _order = loadedOrder;
    }

    notifyListeners();
  }

  void _resetOrder(String establishmentId) {
    _order = OrderModel.empty().copyWith(establishmentId: establishmentId);
  }
}
