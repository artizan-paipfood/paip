import 'package:paipfood_package/paipfood_package.dart';

class TableTurnOccupiedUsecase {
  final TableRepository tableRepo;
  final UpdateQueusRepository updateQueusRepo;
  TableTurnOccupiedUsecase({
    required this.tableRepo,
    required this.updateQueusRepo,
  });
  Future<List<TableModel>> call(List<TableModel> tables) async {
    tables = tables.map((table) => table.copyWith(status: TableStatus.occupied)).toList();
    final result = await tableRepo.upsert(tables: tables, auth: AuthNotifier.instance.auth);
    for (final table in tables) {
      await updateQueusRepo.upsert(UpdateQueusModel.fromTable(table));
    }
    return result;
  }
}
