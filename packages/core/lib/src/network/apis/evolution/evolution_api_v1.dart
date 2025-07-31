import 'package:core/core.dart';

class EvolutionApiV1 implements IEvolutionApi {
  final IClient client;
  EvolutionApiV1({
    required this.client,
  });
  @override
  Future<void> sendLocation({
    required String instance,
    required String phone,
    required double latitude,
    required double longitude,
    required String title,
    String? subtitle,
    Duration? delay,
  }) async {
    Map<String, dynamic> data = {
      "number": phone,
      "locationMessage": {
        "latitude": latitude,
        "longitude": longitude,
        "name": title,
      },
    };
    if (subtitle != null) {
      data["locationMessage"]["address"] = subtitle;
    }
    if (delay != null) {
      data["options"] = {
        "delay": delay.inMilliseconds,
        "presence": "composing",
      };
    }
    await client.post(
      "/message/sendLocation/$instance",
      data: data,
    );
  }

  @override
  Future<void> sendMediaBase64({
    required String instance,
    required String phone,
    required EvolutionMediaType mediaType,
    required String mediaBase64,
    String? description,
    Duration? delay,
  }) async {
    Map<String, dynamic> data = {
      "number": phone,
      "mediaMessage": {
        "mediaType": mediaType.name,
        "media": mediaBase64,
      },
    };
    if (description != null) {
      data["mediaMessage"]["caption"] = description;
    }
    if (delay != null) {
      data["options"] = {
        "delay": delay.inMilliseconds,
        "presence": "composing",
      };
    }
    await client.post(
      "/message/sendMedia/$instance",
      data: data,
    );
  }

  @override
  Future<void> sendText({
    required String instance,
    required String phone,
    required String text,
    Duration? delay,
  }) async {
    Map<String, dynamic> data = {
      "number": phone,
      "options": {
        "linkPreview": text.contains(
          "http",
        ),
      },
      "textMessage": {
        "text": text,
      },
    };
    if (delay != null) {
      data["options"]["delay"] = delay.inMilliseconds;
      data["options"]["presence"] = "composing";
    }

    await client.post(
      "/message/sendText/$instance",
      data: data,
    );
  }
}
