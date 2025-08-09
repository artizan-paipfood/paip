import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:paipfood_package/paipfood_package.dart';

final ValueNotifier<EstablishmentModel> establishmentProvider = ValueNotifier(EstablishmentModel(
  companySlug: '',
  id: '',
));

// Encapsulando os ValueNotifiers em uma classe centralizada
class GlobalState {
  GlobalState._();

  static GlobalState instance = GlobalState._();

  static final ValueNotifier<Map<int, TableModel>> tablesNotifier = ValueNotifier({});
  Map<int?, List<TableModel>> grouParentTable = {};
  static final ValueNotifier<Map<int, OrderCommandModel>> orderCommandsNotifier = ValueNotifier({});
}

class DataSource extends ChangeNotifier {
  // Armazenamento local de estado
  List<EstablishmentModel> establishments = [];
  CompanyModel company = CompanyModel(slug: '', paymentFlagsApp: []);
  Map<String, DriverAndUserAdapter> deliveryMen = {};
  DriverAndUserAdapter? connectDeliveryMen;

  void setEstablishment(EstablishmentModel establishment) {
    establishmentProvider.value = establishment;
  }

  // Mesas
  ValueNotifier<Map<int, TableModel>> get tablesNotifier => GlobalState.tablesNotifier;

  List<TableModel> get tables => GlobalState.tablesNotifier.value.values.toList();

  TableModel? getTableByNumber(int number) => GlobalState.tablesNotifier.value[number];

  bool isTableParent(int number) => GlobalState.instance.grouParentTable.containsKey(number);

  void setTable(TableModel table) {
    GlobalState.tablesNotifier.value = {
      ...GlobalState.tablesNotifier.value,
      table.number: table,
    };
    _groupTables();
  }

  List<int> getTableGroup(TableModel table) {
    final int parentTableNumber = table.tableParentNumber ?? table.number;
    final group = GlobalState.instance.grouParentTable[parentTableNumber];
    if (group != null) {
      final Set<int> result = group.map((table) => table.number).toSet();
      return {parentTableNumber, ...result}.toList();
    }
    return [];
  }

  void _groupTables() {
    final group = tables.groupListsBy((element) => element.tableParentNumber);
    GlobalState.instance.grouParentTable = group;
  }

  void setTables(List<TableModel> tables) {
    final updatedTables = {...GlobalState.tablesNotifier.value};
    for (var table in tables) {
      updatedTables[table.number] = table;
    }
    GlobalState.tablesNotifier.value = updatedTables;
    _groupTables();
  }

  void removeTable(TableModel table) {
    GlobalState.tablesNotifier.value = {
      ...GlobalState.tablesNotifier.value..remove(table.number),
    };
    _groupTables();
  }

  // Comandas
  ValueNotifier<Map<int, OrderCommandModel>> get orderCommandsNotifier => GlobalState.orderCommandsNotifier;

  List<OrderCommandModel> get orderCommands => GlobalState.orderCommandsNotifier.value.values.toList();

  void setOrderCommand(OrderCommandModel orderCommand) {
    GlobalState.orderCommandsNotifier.value = {
      ...GlobalState.orderCommandsNotifier.value,
      orderCommand.number: orderCommand,
    };
  }

  void removeOrderCommand(OrderCommandModel orderCommand) {
    GlobalState.orderCommandsNotifier.value = {
      ...GlobalState.orderCommandsNotifier.value..remove(orderCommand.number),
    };
  }

  // Dados auxiliares

  MenuDto menuVm = MenuDto();
  List<OpeningHoursModel> openingHours = [];
}
