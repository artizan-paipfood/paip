import 'package:core/core.dart';

class TestBaseOptions {
  TestBaseOptions._();
  static BaseOptions supabase = BaseOptions(
    baseUrl: EnvTest.supaBaseUrl,
    headers: {
      'apikey': EnvTest.supaApiKey,
    },
  );
}
