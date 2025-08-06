import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PlansViewmodel {
  final IPlansRepository planRepo;

  PlansViewmodel({required this.planRepo});

  Future<List<PlansModel>> getEnablesByCountry() async {
    final plans = await planRepo.getEnablesByCountry(AppLocaleCode.br);
    plans.sort((a, b) => a.price.compareTo(b.price));
    return plans;
  }
}
