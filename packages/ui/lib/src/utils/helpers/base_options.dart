import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class PaipBaseOptions {
  PaipBaseOptions._();
  static final BaseOptions supabase = BaseOptions(
    baseUrl: Env.supaBaseUrl,
    headers: {
      "apikey": Env.supaApiKey,
      "Content-Type": "application/json",
      "Prefer": "return=representation",
    },
  );
}
