import 'dart:math' hide log;
import 'package:flutter/material.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/bills_store.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_bill_usecase.dart';
import 'package:manager/src/modules/table/aplication/usecases/link_table_usecase.dart';
import 'package:manager/src/modules/table/aplication/usecases/table_turn_avaliable_usecase.dart';
import 'package:manager/src/modules/table/aplication/usecases/table_turn_occupied_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TableStore extends ChangeNotifier {
  final ITableAreaRepository tableAreaRepo;
  final ITableRepository tableRepo;
  final DataSource dataSource;
  final TableTurnAvaliableUsecase tableTurnAvaliableUsecase;
  final TableTurnOccupiedUsecase tableTurnOccupiedUsecase;
  final LinkTableUsecase linkTableUsecase;
  final UpsertBillUsecase upsertBillUsecase;
  TableStore({
    required this.tableAreaRepo,
    required this.tableRepo,
    required this.dataSource,
    required this.tableTurnAvaliableUsecase,
    required this.linkTableUsecase,
    required this.tableTurnOccupiedUsecase,
    required this.upsertBillUsecase,
  }) {
    load();
  }

  String get establishmentId => establishmentProvider.value.id;
  DateTime date = DateTime.now();
  bool isLoaded = false;

  List<TableAreaModel> _tableAreas = [];
  List<TableAreaModel> get tableAreas => _tableAreas;
  // List<TableAreaModel> get _tableAreasUpdated =>
  //     _tableAreas.where((tableArea) => tableArea.updatedAt == null || tableArea.updatedAt!.pNormalizeToCondition().isAfter(date)).toList();

  // List<TableModel> _tables = [];

  List<int> getTableGroup(TableModel table) => dataSource.getTableGroup(table);
  bool isTableParent(int number) => dataSource.isTableParent(number);
  List<TableModel> get tables => dataSource.tables;
  List<TableModel> get _tablesUpdated => tables.where((table) => table.updatedAt == null || table.updatedAt!.pNormalizeToCondition().isAfter(date)).toList();

  void notify() => notifyListeners();
  Future<void> load() async {
    date = DateTime.now().add(3.seconds);
    if (isLoaded) return;
    _tableAreas = await tableAreaRepo.getByEstablishmentId(establishmentId);
    dataSource.setTables(await tableRepo.getByEstablishmentId(establishmentId));
    await _buildFirstTable();
    isLoaded = true;
  }

  bool isTableView = true;

  Future<void> _buildFirstTable() async {
    if (_tableAreas.isNotEmpty) return;
    await addTableArea(TableAreaModel(id: uuid, establishmentId: establishmentId, name: 'Salao principal'));
  }

  late TableAreaModel _selectedTableArea = _tableAreas.first;
  TableAreaModel get selectedTableArea => _selectedTableArea;

  TableModel? getTableByNumber(int number) => dataSource.getTableByNumber(number);

  int? _selectedTableNumber;

  TableModel? get selectedTable {
    if (_selectedTableNumber == null) return null;
    return dataSource.getTableByNumber(_selectedTableNumber!);
  }

  void toggleOnView(bool value) {
    isTableView = value;
    notifyListeners();
  }

  Future<void> linkTables(TableModel table1, TableModel table2) async {
    await linkTableUsecase.call(tables: [table1, table2]);
  }

  Future<void> separateTable(TableModel table) async {
    table
      ..tableParentNumber = null
      ..billId = null;
    table = table.copyWith(status: TableStatus.available);
    dataSource.setTable(table);
  }

  void setSelectedTable(TableModel? table) async {
    if (_selectedTableNumber == table?.number || table == null) {
      _selectedTableNumber = null;
    } else {
      _selectedTableNumber = table.number;
    }
    notifyListeners();
  }

  TableModel? getTableByPosition(int index) {
    return tables.firstWhereOrNull((t) => t.index == index && t.tableAreaId == selectedTableArea.id);
  }

  void setSelectedTableArea(TableAreaModel tableArea) async {
    _selectedTableArea = tableArea;
    notifyListeners();
  }

  Future<void> addTable(int index) async {
    final table = TableModel(number: _getNextTableNumber(min(1, tables.length + 1)), establishmentId: establishmentId, index: index, tableAreaId: selectedTableArea.id);
    dataSource.setTable(table);

    setSelectedTable(table);
    notifyListeners();
  }

  bool existsTableByNumber(int number) {
    final table = tables.firstWhereOrNull((t) => t.number == number);
    return table != null;
  }

  Future<void> turnTableToAvaliable(TableModel table) async {
    final List<TableModel> tables = _getTablesInGroup(table);
    final result = await tableTurnAvaliableUsecase.call(tables);
    dataSource.setTables(result);
    notifyListeners();
  }

  Future<void> turnTableToOccupied(TableModel table) async {
    final List<TableModel> tables = _getTablesInGroup(table);
    final result = await tableTurnOccupiedUsecase.call(tables);
    dataSource.setTables(result);
    notifyListeners();
  }

  List<TableModel> _getTablesInGroup(TableModel table) {
    final List<TableModel> tables = [table];

    if (dataSource.isTableParent(table.number)) {
      tables.clear();
      dataSource.getTableGroup(table).forEach((number) {
        tables.add(dataSource.getTableByNumber(number)!);
      });
    }
    return tables;
  }

  int _getNextTableNumber(int number) {
    final tableExists = existsTableByNumber(number);
    if (tableExists) {
      return _getNextTableNumber(number + 1);
    }
    return number;
  }

  Future<void> tranferTable({required TableModel table, required TableModel transferTable}) async {
    if (transferTable.tableParentNumber != null) {
      transferTable = dataSource.getTableByNumber(transferTable.tableParentNumber!)!;
    }
    transferTable = transferTable.copyWith(billId: table.billId);
    final bill = BillsStore.instance.getBillById(table.billId!);

    table.billId = null;
    dataSource.setTables([table, transferTable]);

    await upsertBillUsecase.call(bill!.copyWith(tableNumber: transferTable.number));

    await turnTableToOccupied(transferTable);

    await turnTableToAvaliable(table);
  }

  int _getIndexDisponibleByTableArea({required TableAreaModel tableArea, required int index}) {
    final containsTableInIndex = tables.firstWhereOrNull((t) => t.tableAreaId == tableArea.id && t.index == index);
    if (containsTableInIndex == null) return index;
    return _getIndexDisponibleByTableArea(tableArea: tableArea, index: index + 1);
  }

  void deleteTable(TableModel table) {
    dataSource.removeTable(table);
    _selectedTableNumber = null;
    notifyListeners();
  }

  Future<void> deleteTableArea(TableAreaModel tableArea) async {
    if (_tableAreas.length == 1) return;
    final tablesResult = tables.where((t) => t.tableAreaId == tableArea.id).toList();
    for (final table in tablesResult) {
      dataSource.removeTable(table);
    }
    _tableAreas.remove(tableArea);
    setSelectedTableArea(_tableAreas.first);
    await tableAreaRepo.delete(id: tableArea.id, auth: AuthNotifier.instance.auth);
    notifyListeners();
  }

  Future<void> updateTable(TableModel table) async {
    final oldTable = tables.firstWhere((t) => t.number == table.number);
    if (oldTable.tableAreaId == table.tableAreaId) {
      dataSource.setTable(table.copyWith());
    } else {
      final tableArea = _tableAreas.firstWhere((t) => t.id == table.tableAreaId);
      final index = _getIndexDisponibleByTableArea(tableArea: tableArea, index: table.index!);
      dataSource.setTable(table.copyWith(index: index));
      setSelectedTableArea(tableArea);
    }
    setSelectedTable(table);
    notifyListeners();
  }

  Future<void> addTableArea(TableAreaModel tableArea) async {
    _tableAreas.add(tableArea);
    setSelectedTableArea(tableArea);
    await tableAreaRepo.upsert(tableAreas: [tableArea], auth: AuthNotifier.instance.auth);
    notifyListeners();
  }

  Future<void> changeTablePosition({required int oldIndex, required int newIndex}) async {
    final table = tables.firstWhere((t) => t.index == oldIndex);
    dataSource.setTable(table.copyWith(index: newIndex));
    notifyListeners();
  }

  Future<void> saveTables() async {
    final updateds = _tablesUpdated;
    if (updateds.isEmpty) return;
    await tableRepo.upsert(tables: updateds, auth: AuthNotifier.instance.auth);
    final bool callDelete = updateds.any((e) => e.isDeleted);
    if (callDelete) await _deleteTables();
    setSelectedTable(null);
    await load();
  }

  Future<void> _deleteTables() async {
    await tableRepo.delete(id: '', auth: AuthNotifier.instance.auth, isDeleted: true);
  }
}
