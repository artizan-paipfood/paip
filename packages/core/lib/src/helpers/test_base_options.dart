import 'package:core/core.dart';

class TestBaseOptions {
  TestBaseOptions._();
  static BaseOptions supabase = BaseOptions(
    baseUrl: 'https://localhost:3000',
    headers: {},
  );
}
