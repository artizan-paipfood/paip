import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:store/src/domain/models/store_model.dart';

class StoreViewmodel {
  final ViewsApi viewsApi;
  StoreViewmodel({required this.viewsApi});

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  ValueNotifier<bool> get load => _isLoading;

  StoreModel? _store;

  bool get isInitialized => _store != null;

  EstablishmentEntity? get establishment => _store?.data.establishment;
  AddressEntity? get establishmentAddress => _store?.data.address;

  OpeningHoursEntity? get openingHoursToday => _store?.data.openingHours.firstWhereOrNull((e) => e.weekDayId == DateTime.now().weekday);

  List<CategoryEntity> get categories => _store?.data.menu.categories.values.sorted((a, b) => a.index?.compareTo(b.index ?? 0) ?? 0).toList() ?? [];

  Future<void> initialize(String establishmentId) async {
    if (isInitialized) return;
    _isLoading.value = true;
    final view = await viewsApi.getEstablishmentMenuView(establishmentId: establishmentId);
    AppLocale.setAppLocale(view.establishment.locale!);
    _store = StoreModel(data: view);
    _isLoading.value = false;
  }

  List<ProductEntity> productsByCategory(String categoryId) => _store?.data.menu.products.values.where((e) => e.categoryId == categoryId).toList().sorted((a, b) => a.index?.compareTo(b.index ?? 0) ?? 0) ?? [];
}
