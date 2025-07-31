import 'package:core/core.dart' hide JwtService;
import 'package:core_flutter/core_flutter.dart';
import 'package:paipfood_package/paipfood_package.dart';

class HttpUtils {
  HttpUtils._();

  static Map<String, dynamic> headerUpsert = {
    "Prefer": ["resolution=merge-duplicates", "return=representation"],
  };

  static BaseOptions supabaseBaseoptions = BaseOptions(baseUrl: Env.supaBaseUrl, headers: {
    "apikey": Env.supaApiKey,
    "Content-Type": "application/json",
    "Prefer": "return=representation",
  });

  static BaseOptions customFunctionsBaseOptions = BaseOptions(baseUrl: "https://vipwbbuyhszmxdjsclzg.supabase.co/rest/v1/rpc", headers: {
    "apikey": Env.supaApiKey,
    "Content-Type": "application/json",
  });

  static BaseOptions waiterBaseOptions = BaseOptions(baseUrl: Env.isDev ? "http://localhost:8090/api" : "https://waiter-0fb37f04f647.herokuapp.com/api", headers: {
    "Content-Type": "application/json",
  });

  static BaseOptions idealPostcode = BaseOptions(
      baseUrl: "https://api.ideal-postcodes.co.uk", headers: {'Content-Type': 'application/json', if (Env.isDev) 'referer': 'https://docs.ideal-postcodes.co.uk/'}, queryParameters: {if (Env.isDev) 'api_key': 'iddqd' else 'api_key': 'ak_lyqxvu47fdeqn2uf7rQxd8KeGuomj'});

  static BaseOptions wppEvolutionOptions = BaseOptions(headers: {
    "apikey": Env.evolutionGlobalApiKey,
    "Content-Type": "application/json; charset=utf-8",
  });

  static String hostWppWin = "http://localHost:3000";
  static String hostWppContabo = "https://wppservice.paipfood.com";

  static BaseOptions api() {
    final token = JwtService.buildToken(map: JwtService.toMap('aloha'), expiresIn: const Duration(days: 5), secret: Env.secretKey);
    return BaseOptions(
      baseUrl: Env.parseLocalhost(Env.apiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  static BaseOptions wppBaseOptions = BaseOptions(
    //baseUrl: ,
    headers: {
      "accept": "*/*",
      "Content-Type": "application/json; charset=utf-8",
    },
    sendTimeout: 5000.milliseconds,
    connectTimeout: 5000.milliseconds,
    receiveTimeout: 5000.milliseconds,
  );

  static BaseOptions bucketSupabase = BaseOptions(baseUrl: "https://vipwbbuyhszmxdjsclzg.supabase.co/storage/v1/", headers: {
    "Authorization": "Bearer ${Env.supaApiKey}",
    "Content-Type": "application/json",
  });

  static BaseOptions mercadoPago = BaseOptions(
    baseUrl: 'https://api.mercadopago.com/',
  );
  static BaseOptions messageBaseUrl = BaseOptions(baseUrl: Env.smsBaseUrl, headers: {
    'Authorization': Env.smsApiKey,
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });

  static Map<String, dynamic> headerAuth(AuthModel auth) => {
        "Authorization": "Bearer ${auth.accessToken}",
      };

  static Map<String, dynamic> headerUpsertAuth(AuthModel auth) => {
        "Authorization": "Bearer ${auth.accessToken}",
        "Prefer": ["resolution=merge-duplicates", "return=representation"],
      };

  static String filterVisible(bool visible) => "&visible=eq.$visible";
  static String queryIsDeleted(bool isDeleted) => "is_deleted=eq.$isDeleted";
}
