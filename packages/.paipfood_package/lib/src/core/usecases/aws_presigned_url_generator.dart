import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

/// Gerador de URLs pré-assinadas para AWS S3
/// Baseado no exemplo fornecido usando AWS Signature V4
class AwsPresignedUrlGenerator {
  final String accessKey;
  final String secretKey;
  final String region;
  final String bucketName;

  AwsPresignedUrlGenerator({
    required this.accessKey,
    required this.secretKey,
    required this.region,
    required this.bucketName,
  });

  /// Gera uma URL pré-assinada para um arquivo específico
  String call(String fileName, {Duration expiration = const Duration(hours: 1), String method = 'GET'}) {
    final now = DateTime.now().toUtc();
    final expiresInSeconds = expiration.inSeconds;

    // Formatar data no formato AWS
    final dateStr = DateFormat('yyyyMMdd').format(now);
    final datetimeStr = DateFormat("yyyyMMdd'T'HHmmss'Z'").format(now);

    // Construir host e path
    final host = '$bucketName.s3.$region.amazonaws.com';
    final path = '/$fileName';

    // Construir credencial scope
    final credentialScope = '$dateStr/$region/s3/aws4_request';
    final credential = '$accessKey/$credentialScope';

    // Query parameters básicos
    final queryParams = <String, String>{
      'X-Amz-Algorithm': 'AWS4-HMAC-SHA256',
      'X-Amz-Credential': credential,
      'X-Amz-Date': datetimeStr,
      'X-Amz-Expires': expiresInSeconds.toString(),
      'X-Amz-SignedHeaders': 'host',
    };

    // Criar canonical query string
    final sortedKeys = queryParams.keys.toList()..sort();
    final canonicalQueryString = sortedKeys.map((key) => '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(queryParams[key]!)}').join('&');

    // Criar canonical request
    final canonicalRequest = [
      method,
      path,
      canonicalQueryString,
      'host:$host',
      '',
      'host',
      'UNSIGNED-PAYLOAD',
    ].join('\n');

    // Criar string to sign
    final stringToSign = [
      'AWS4-HMAC-SHA256',
      datetimeStr,
      credentialScope,
      sha256.convert(utf8.encode(canonicalRequest)).toString(),
    ].join('\n');

    // Calcular assinatura
    final signature = _calculateSignature(stringToSign, dateStr);

    // Adicionar assinatura aos query params
    final finalQueryString = '$canonicalQueryString&X-Amz-Signature=$signature';

    return 'https://$host$path?$finalQueryString';
  }

  /// Calcula a assinatura AWS V4
  String _calculateSignature(String stringToSign, String dateStr) {
    final kDate = _hmacSha256(utf8.encode('AWS4$secretKey'), dateStr);
    final kRegion = _hmacSha256(kDate, region);
    final kService = _hmacSha256(kRegion, 's3');
    final kSigning = _hmacSha256(kService, 'aws4_request');
    final signature = _hmacSha256(kSigning, stringToSign);

    return signature.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Função auxiliar para HMAC-SHA256
  List<int> _hmacSha256(List<int> key, String data) {
    final hmac = Hmac(sha256, key);
    return hmac.convert(utf8.encode(data)).bytes;
  }
}
