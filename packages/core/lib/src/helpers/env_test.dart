import 'package:core/core.dart';

class EnvTest {
  EnvTest._();
  static String apiBaseUrl = _loadString('API_BASE_URL');

  static String secretKey = _loadString('SECRET_KEY');

  static String encryptKey = _loadString('ENCRYPT_KEY');

  static String stripePublishableKey = _loadString("STRIPE_PUBLISHABLE_KEY");

  static String stripePublishableKeyTest = _loadString("STRIPE_PUBLISHABLE_KEY_TEST");

  static bool isDev = _loadBool('IS_DEV');

  static String supaApiKey = _loadString('SUPA_API_KEY');

  static String supaBaseUrl = _loadString('SUPA_BASE_URL');

  static String geoapifyApiKey = _loadString('GEOAPIFY_API_KEY');

  static String mapboxlight = _loadString('MAPBOX_LIGHT');

  static String mapboxDark = _loadString('MAPBOX_DARK');

  static String mapboxApiKey = _loadString('MAPBOX_API_KEY');

  static String googlemapsApiKey = _loadString('GOOGLEMAPS_API_KEY');

  static String mercadoPagoClientId = _loadString('MERCADO_PAGO_CLIENT_ID');

  static String mercadoPagoAcessToken = _loadString('MERCADO_ACCESS_TOKEN');

  static String mercadoPagoClientSecret = _loadString('MERCADO_PAGO_CLIENT_SECRET');

  static String smsBaseUrl = _loadString('SMS_BASE_URL');

  static String smsApiKey = _loadString('SMS_API_KEY');

  static String awsAccessKeyId = _loadString('AWS_ACCESS_KEY_ID');

  static String awsSecretAccessKey = _loadString('AWS_SECRET_ACCESS_KEY');

  static String evolutionBaseUrl = _loadString('EVOLUTION_BASE_URL');

  static String evolutionGlobalApiKey = _loadString('EVOLUTION_GLOBAL_API_KEY');

  static String parseLocalhost(String url) {
    // if (isAndroid) return url.replaceAll('localhost', '10.0.2.2');
    return '';
  }

  static Future<void> initializeForTest({String? envFilePath}) async {
    if (envFilePath != null) {
      await EnvReader.loadEnvFile(envFilePath);
    }
  }

  static String _loadString(String key) {
    return EnvReader.loadString(key) ?? String.fromEnvironment(key);
  }

  static bool _loadBool(String key) {
    return EnvReader.loadBool(key) ?? bool.fromEnvironment(key);
  }
}
