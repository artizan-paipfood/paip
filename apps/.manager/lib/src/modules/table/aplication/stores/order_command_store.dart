import 'package:flutter/material.dart';

import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/bills_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderCommandStore extends ChangeNotifier {
  final OrderCommandRepository orderCommandRepo;
  final DataSource dataSource;
  OrderCommandStore({
    required this.orderCommandRepo,
    required this.dataSource,
  }) {
    load();
  }

  DateTime date = DateTime.now();
  bool isLoaded = false;

  List<OrderCommandModel> _orderCommands = [];
  final List<OrderCommandModel> _orderCommandsDeleteds = [];
  List<OrderCommandModel> get orderCommands => _orderCommands;
  List<OrderCommandModel> get _comandsUpdated => _orderCommands.where((orderCommand) => orderCommand.updatedAt == null || orderCommand.updatedAt!.pNormalizeToCondition().isAfter(date)).toList();

  String get establishmentId => establishmentProvider.value.id;

  late final listeners = Listenable.merge([this, dataSource.orderCommandsNotifier, BillsStore.instance]);

  Future<void> load() async {
    date = DateTime.now().add(3.seconds);
    if (isLoaded) return;
    _orderCommands = await orderCommandRepo.getByEstablishmentId(establishmentId);
    isLoaded = true;
  }

  Future<void> addComand() async {
    if (_orderCommandsDeleteds.isEmpty) {
      _orderCommands.add(OrderCommandModel(number: orderCommands.length + 1, createdAt: DateTime.now(), establishmentId: establishmentId));
    } else {
      _orderCommandsDeleteds.sort((a, b) => a.number.compareTo(b.number));
      _orderCommands.add(_orderCommandsDeleteds.first.copyWith(isDeleted: false));
      _orderCommandsDeleteds.remove(_orderCommandsDeleteds.first);
    }
    notifyListeners();
  }

  Future<void> deleteComand() async {
    _orderCommandsDeleteds.add(_orderCommands.sorted((a, b) => a.number.compareTo(b.number)).last.copyWith(isDeleted: true));
    _orderCommands.remove(_orderCommands.last);
    notifyListeners();
  }

  Future<void> save() async {
    final updateds = _comandsUpdated;
    if (updateds.isEmpty && _orderCommandsDeleteds.isEmpty) return;
    final bool callDelete = _orderCommandsDeleteds.isNotEmpty;
    await orderCommandRepo.upsert(
      orderCommands: [...updateds, ..._orderCommandsDeleteds.where((command) => command.updatedAt != null)],
      auth: AuthNotifier.instance.auth,
    );
    if (callDelete) await _delete();
    await load();
  }

  Future<void> _delete() async {
    await orderCommandRepo.delete(id: '', auth: AuthNotifier.instance.auth, isDeleted: true);
  }
}
