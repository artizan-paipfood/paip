import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddOrderCommandRealtimeUsecase {
  final DataSource dataSource;

  AddOrderCommandRealtimeUsecase(this.dataSource);
  void call(Map map) {
    final orderCommand = OrderCommandModel.fromMap(map);
    dataSource.setOrderCommand(orderCommand);
  }
}
