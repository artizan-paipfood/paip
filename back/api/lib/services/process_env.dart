// ignore_for_file: unused_element

import 'dart:io';

import 'package:core/core.dart';

class ProcessEnv {
  ProcessEnv._();

  static int get port => _loadInt('PORT');
  static String get secrectKey => _loadString('SECRETE_KEY');
  static int get tokenExpiration => _loadInt('TOKEN_EXPIRATION');
  static int get refreshTokenExpiration => _loadInt('REFRESH_TOKEN_EXPIRATION');
  static String get googleMapsApikey => _loadString('GOOGLE_MAPS_APIKEY');
  static String get geoapifyApikey => _loadString('GEOAPIFY_APIKEY');
  static String get supabaseApikey => _loadString('SUPABASE_APIKEY');
  static String get supabaseBaseurl => _loadString('SUPABASE_BASEURL');
  static String get brStripeScretKey => _loadString('BR_STRIPE_SCRET_KEY');
  static String get gbStripeScretKey => _loadString('GB_STRIPE_SCRET_KEY');
  static String get corsOrigin => _loadString('CORS_ORIGIN');
  static String get evolutionApiKey => _loadString('EVOLUTION_APIKEY');
  static String get hipayApiKey => _loadString('HIPAY_APIKEY');
  static String get mapboxAccessToken => _loadString('MAPBOX_ACCESSTOKEN');
  static String get radarSecretKey => _loadString('RADAR_SECRET_KEY');
  static String get awesomeApiToken => _loadString('AWESOME_API_TOKEN');

  static Future<void> initializeForTest({String? envFilePath}) async {
    if (envFilePath != null) {
      await EnvReader.loadEnvFile(envFilePath);
    }
  }

  static int _loadInt(String key) {
    return int.parse((Platform.environment[key] ?? EnvReader.loadString(key))!.toString());
  }

  static String _loadString(String key) {
    return (Platform.environment[key] ?? EnvReader.loadString(key))!.toString();
  }

  static bool _loadBool(String key) {
    return (Platform.environment[key] ?? EnvReader.loadBool(key).toString()).toLowerCase() == 'true';
  }
}
