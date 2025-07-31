import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UpdateQueusRepository implements IUpdateQueusRepository {
  final IClient http;
  UpdateQueusRepository({
    required this.http,
  });
  static String table = "update_queus";
  @override
  Future<void> upsert(UpdateQueusModel updateQueus) async {
    await http.post(
      "/rest/v1/$table",
      headers: HttpUtils.headerUpsertAuth(AuthNotifier.instance.auth),
      data: updateQueus.toMap(),
    );
  }
}
