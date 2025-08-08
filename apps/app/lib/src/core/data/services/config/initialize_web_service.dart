import 'package:core_flutter/core_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:geolocator/geolocator.dart';

class InitializeWebService {
  InitializeWebService._();

  static Future<void> initialize() async {
    if (!isWeb) return;
    usePathUrlStrategy();

    // Inicialização específica para geolocator na web
    await _initializeGeolocator();
  }

  static Future<void> _initializeGeolocator() async {
    try {
      // Verifica se o serviço de localização está habilitado
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Se não estiver habilitado, não faz nada - será tratado pelo MyPositionService
        return;
      }

      // Verifica permissões
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Se as permissões forem negadas, não faz nada - será tratado pelo MyPositionService
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return;
      }
    } catch (e) {
      // Se houver qualquer erro, não faz nada - será tratado pelo MyPositionService
      return;
    }
  }
}
