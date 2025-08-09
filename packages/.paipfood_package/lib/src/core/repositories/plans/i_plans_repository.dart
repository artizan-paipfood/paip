import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IPlansRepository {
  Future<List<PlansModel>> getEnablesByCountry(AppLocaleCode locale);
}
