import 'package:core_flutter/src/utils/helpers/env.dart';
import 'package:core_flutter/src/dependencies.dart';

class PaipBaseOptions {
  PaipBaseOptions._();
  static final BaseOptions supabase = BaseOptions(baseUrl: Env.supaBaseUrl, headers: {"apikey": Env.supaApiKey, "Content-Type": "application/json", "Prefer": "return=representation"});
}
