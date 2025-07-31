import 'package:core_flutter/src/utils/platform/platform.dart';

class Env {
  Env._();
  static String apiBaseUrl = const String.fromEnvironment('API_BASE_URL');

  static String secretKey = const String.fromEnvironment('SECRET_KEY');

  static String encryptKey = const String.fromEnvironment('ENCRYPT_KEY');

  static String stripePublishableKey = const String.fromEnvironment("STRIPE_PUBLISHABLE_KEY");

  static String stripePublishableKeyTest = const String.fromEnvironment("STRIPE_PUBLISHABLE_KEY_TEST");

  static bool isDev = const bool.fromEnvironment('IS_DEV');

  static String supaApiKey = const String.fromEnvironment('SUPA_API_KEY');

  static String supaBaseUrl = const String.fromEnvironment('SUPA_BASE_URL');

  static String geoapifyApiKey = const String.fromEnvironment('GEOAPIFY_API_KEY');

  static String mapboxlight = const String.fromEnvironment('MAPBOX_LIGHT');

  static String mapboxDark = const String.fromEnvironment('MAPBOX_DARK');

  static String mapboxApiKey = const String.fromEnvironment('MAPBOX_API_KEY');

  static String googlemapsApiKey = const String.fromEnvironment('GOOGLEMAPS_API_KEY');

  static String mercadoPagoClientId = const String.fromEnvironment('MERCADO_PAGO_CLIENT_ID');

  static String mercadoPagoAcessToken = const String.fromEnvironment('MERCADO_ACCESS_TOKEN');

  static String mercadoPagoClientSecret = const String.fromEnvironment('MERCADO_PAGO_CLIENT_SECRET');

  static String smsBaseUrl = const String.fromEnvironment('SMS_BASE_URL');

  static String smsApiKey = const String.fromEnvironment('SMS_API_KEY');

  static String awsAccessKeyId = const String.fromEnvironment('AWS_ACCESS_KEY_ID');

  static String awsSecretAccessKey = const String.fromEnvironment('AWS_SECRET_ACCESS_KEY');

  static String evolutionBaseUrl = const String.fromEnvironment('EVOLUTION_BASE_URL');

  static String evolutionGlobalApiKey = const String.fromEnvironment('EVOLUTION_GLOBAL_API_KEY');

  static String parseLocalhost(String url) {
    if (isAndroid) return url.replaceAll('localhost', '10.0.2.2');
    return url;
  }
}
