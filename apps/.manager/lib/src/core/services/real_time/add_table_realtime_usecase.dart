import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddTableRealtimeUsecase {
  final DataSource dataSource;

  AddTableRealtimeUsecase(this.dataSource);
  void call(Map map) {
    final table = TableModel.fromMap(map);
    dataSource.setTable(table);
  }
}
