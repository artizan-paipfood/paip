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

  static BaseOptions get paipApi {
    final token = JwtService.generateToken(payload: {"token": 'teste'}, secretKey: Env.secretKey, expiresIn: const Duration(minutes: 30));
    return BaseOptions(
      baseUrl: Env.parseLocalhost(Env.apiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
