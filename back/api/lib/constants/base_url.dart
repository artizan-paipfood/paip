import 'package:core/core.dart';
import 'package:api/infra/services/process_env.dart';

class BaseUrl {
  BaseUrl._();

  static const String googleGeocode = 'https://maps.googleapis.com/maps/api/geocode';
  static const String googleAutocomplete = 'https://maps.googleapis.com/maps/api/place/autocomplete';
  static const String geoapify = 'https://api.geoapify.com';
  static const String mapbox = 'https://api.mapbox.com';
  static String get supabase => ProcessEnv.supabaseBaseurl;
  static const String stripe = "https://api.stripe.com";
  static const String evolutionApi = "https://apiwhatsapp.paipfood.com";
}

class DioBaseOptions {
  DioBaseOptions._();
  static BaseOptions get supabase => BaseOptions(baseUrl: BaseUrl.supabase, headers: {"apikey": ProcessEnv.supabaseApikey, "Content-Type": "application/json", "Prefer": "return=representation"});
  static BaseOptions get stripe => BaseOptions(baseUrl: BaseUrl.stripe);
  static BaseOptions get evolutionApi => BaseOptions(baseUrl: BaseUrl.evolutionApi, headers: {"apikey": ProcessEnv.evolutionApiKey, "Content-Type": "application/json; charset=utf-8"});
}
