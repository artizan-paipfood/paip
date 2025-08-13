import 'dart:typed_data';
import 'package:aws_client/s3_2006_03_01.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:image/image.dart' as img;

class CloudFlareR2Constants {
  CloudFlareR2Constants._();
  static String region = 'auto';
  static String accountId = 'd7f410d495c8f2d6a2319a2a6456c330';
  static String tokenValue = '1B_AkjhC2bWPdL-LtLemCGO4rtu5ez7xTH27Phcu';
  static String accessKeyId = '9a9fa18c33b45008665f1dccf72807bd';
  static String secretAccessKey = '0a97ecda77bb0610ab79a958422b9cb07e39570992db4096ed79a8e6f701c3dc';
  static String get endpoint => 'https://$accountId.r2.cloudflarestorage.com';
}

abstract interface class IBucketRepository {
  Future<void> upsertImage({required String fileName, required Uint8List imageBytes});
  Future<void> upsertImageCustom({required String fileName, required Uint8List imageBytes, required int maxSize});
  Future<void> upsertFile({required String fileName, required Uint8List fileBytes});
  Future<void> deletefile(String fileName);
  Future<String> downloadFile({required String path, Function(int, int)? onReceiveProgress});
}

class AwsClient implements IBucketRepository {
  IClient http;
  AwsClient({required this.http});

  S3 buildApiS3() {
    return S3(
      region: CloudFlareR2Constants.region,
      endpointUrl: CloudFlareR2Constants.endpoint,
      credentials: AwsClientCredentials(accessKey: CloudFlareR2Constants.accessKeyId, secretKey: CloudFlareR2Constants.secretAccessKey),
    );
  }

  // final String _baseUrlUploadAws = 'https://bucket.paipfood.com';
  static String baseUrlAws = 'https://pub-e6f06fb0d25440d1a5afe5f8581988b6.r2.dev';
  @override
  Future<void> upsertImage({required String fileName, required Uint8List imageBytes}) async {
    final api = buildApiS3();
    await api.putObject(
      bucket: 'images',
      key: fileName,
      body: compressImageRegular(image: imageBytes),
    );
    await api.putObject(
      bucket: 'images',
      key: "thumb-$fileName",
      body: compressImageThumb(image: imageBytes),
    );
  }

  @override
  Future<void> upsertImageCustom({required String fileName, required Uint8List imageBytes, required int maxSize}) async {
    final api = buildApiS3();
    await api.putObject(
      bucket: 'images',
      key: fileName,
      body: compressImage(image: imageBytes, maxSize: maxSize),
    );
  }

  @override
  Future<void> deletefile(String fileName) async {
    final api = buildApiS3();
    await api.deleteObject(bucket: 'files', key: fileName);
  }

  @override
  Future<void> upsertFile({required String fileName, required Uint8List fileBytes}) async {
    final api = buildApiS3();
    await api.putObject(bucket: 'files', key: fileName, body: fileBytes);
  }

  @override
  Future<String> downloadFile({required String path, Function(int, int)? onReceiveProgress}) async {
    final req = await http.get("https://pub-5108cc6c653d4a298a244cd51036bd2e.r2.dev/$path", onReceiveProgress: onReceiveProgress);
    return req.data;
  }

  Uint8List compressImageRegular({required Uint8List image}) => compressImage(image: image, maxSize: 550);

  Uint8List compressImageThumb({required Uint8List image}) => compressImage(image: image, maxSize: 100);

  Uint8List compressImage({required Uint8List image, required int maxSize}) {
    // Carregar a imagem usando o pacote image
    final img.Image imgData = img.decodeImage(image)!;

    // Calcular a largura e a altura da imagem comprimida com 50% da original
    final double widhtFactor = maxSize / imgData.width;
    final double heightFactor = maxSize / imgData.height;

    final double factor = widhtFactor < heightFactor ? widhtFactor : heightFactor;
    int newWidth = imgData.width;
    int newHeight = imgData.height;

    if (factor < 1) {
      newWidth = (imgData.width * factor).toInt();
      newHeight = (imgData.height * factor).toInt();
    }

    // Comprimir a imagem
    final img.Image compressedImage = img.copyResize(imgData, width: newWidth, height: newHeight);

    // Verificar se a imagem original tem canal alfa (transparência)
    if (imgData.hasAlpha) {
      // Se tiver canal alfa, codificar a imagem comprimida como PNG
      return Uint8List.fromList(img.encodePng(compressedImage));
    } else {
      // Se não tiver canal alfa, codificar a imagem comprimida como JPEG
      return Uint8List.fromList(img.encodeJpg(compressedImage));
    }
  }
}
