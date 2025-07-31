export 'evolution_api_v1.dart';

enum EvolutionMediaType {
  image,
  video,
  audio,
  document;
}

abstract interface class IEvolutionApi {
  Future<void> sendText({required String instance, required String phone, required String text, Duration? delay});

  Future<void> sendMediaBase64({required String instance, required String phone, required EvolutionMediaType mediaType, required String mediaBase64, String? description, Duration? delay});

  Future<void> sendLocation({required String instance, required String phone, required double latitude, required double longitude, required String title, String? subtitle, Duration? delay});
}
