import 'package:core/core.dart';
import 'package:core_flutter/src/utils/platform/platform.dart';

class Env {
  Env._();
  static String apiBaseUrl = const String.fromEnvironment('API_BASE_URL');

  static String secretKey = const String.fromEnvironment('SECRET_KEY');

  static String encryptKey = const String.fromEnvironment('ENCRYPT_KEY');

  static String stripePublishableKey = const String.fromEnvironment("STRIPE_PUBLISHABLE_KEY");

  static bool isDev = const bool.fromEnvironment('IS_DEV');

  static String supaApiKey = const String.fromEnvironment('SUPABASE_API_KEY');

  static String supaBaseUrl = const String.fromEnvironment('SUPABASE_BASE_URL');

  static String geoapifyApiKey = const String.fromEnvironment('GEOAPIFY_API_KEY');

  static String mapboxApiKey = const String.fromEnvironment('MAPBOX_API_KEY');

  static String googlemapsApiKey = const String.fromEnvironment('GOOGLEMAPS_API_KEY');

  static String mercadoPagoClientId = const String.fromEnvironment('MERCADO_PAGO_CLIENT_ID');

  static String mercadoPagoAcessToken = const String.fromEnvironment('MERCADO_ACCESS_TOKEN');

  static String mercadoPagoClientSecret = const String.fromEnvironment('MERCADO_PAGO_CLIENT_SECRET');

  static String smsBaseUrl = const String.fromEnvironment('SMS_BASE_URL');

  static String smsApiKey = const String.fromEnvironment('SMS_API_KEY');

  static String evolutionBaseUrl = const String.fromEnvironment('EVOLUTION_BASE_URL');

  static String evolutionGlobalApiKey = const String.fromEnvironment('EVOLUTION_GLOBAL_API_KEY');

  static String country = const String.fromEnvironment('COUNTRY');

  static String parseLocalhost(String url) {
    if (isAndroid) return url.replaceAll('localhost', '10.0.2.2');
    return url;
  }

  static Future<void> initializeForTest({String? envFilePath}) async {
    if (envFilePath != null) {
      await EnvReader.loadEnvFile(envFilePath);
    }
  }

  // static String const String.fromEnvironment(String key) {
  //   final result = String.fromEnvironment(key);
  //   if (result.isEmpty) throw Exception('Environment variable $key is not set');
  //   return result;
  // }

  static bool _loadBool(String key) {
    return bool.fromEnvironment(key);
  }
}
