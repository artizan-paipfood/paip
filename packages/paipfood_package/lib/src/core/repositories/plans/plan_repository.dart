import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PlanRepository implements IPlansRepository {
  final IClient http;
  PlanRepository({required this.http});

  static const String _table = "plans";

  @override
  Future<List<PlansModel>> getEnablesByCountry(AppLocaleCode locale) async {
    final req = await http.get('/rest/v1/$_table?locale=eq.${locale.name}&enable=eq.true&select=*');
    final List list = req.data;
    return list.map<PlansModel>((plan) {
      return PlansModel.fromMap(plan);
    }).toList();
  }
}
