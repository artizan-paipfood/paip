import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

extension OrderExtension on OrderModel {
  bool get isPaid => charge != null && (charge!.status == ChargeStatus.paid || charge!.status == ChargeStatus.processed);
}
