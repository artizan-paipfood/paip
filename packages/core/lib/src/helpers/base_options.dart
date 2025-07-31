import 'package:core/core.dart';
import 'package:core/src/helpers/env.dart';

class PaipBaseOptions {
  PaipBaseOptions._();
  static BaseOptions supabase = BaseOptions(
    baseUrl: Env.supabaseBaseUrl,
    headers: {},
  );
}
