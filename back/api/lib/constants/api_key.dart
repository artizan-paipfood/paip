import 'package:api/infra/services/process_env.dart';

class ApiKey {
  ApiKey._();

  static String get supabase => ProcessEnv.supabaseApikey;
}
