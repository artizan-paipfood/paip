import 'dart:typed_data';

abstract interface class IBucketRepository {
  Future<void> upsertImage({required String fileName, required Uint8List imageBytes});
  Future<void> upsertImageCustom({required String fileName, required Uint8List imageBytes, required int maxSize});
  Future<void> upsertFile({required String fileName, required Uint8List fileBytes});
  Future<void> deletefile(String fileName);
  Future<String> downloadFile({required String path, Function(int, int)? onReceiveProgress});
}
