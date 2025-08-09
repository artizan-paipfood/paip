import 'package:paipfood_package/src/core/models/update_queus_model.dart';

abstract interface class IUpdateQueusRepository {
  Future<void> upsert(UpdateQueusModel updateQueus);
}
