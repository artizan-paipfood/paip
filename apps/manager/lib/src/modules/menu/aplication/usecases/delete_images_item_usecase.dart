import 'package:paipfood_package/paipfood_package.dart';

class DeleteImagesUsecase {
  IBucketRepository bucketRepo;
  DeleteImagesUsecase({
    required this.bucketRepo,
  });
  Future<void> call(List<String> paths) async {
    await Future.wait(paths.map((e) => bucketRepo.deletefile(e)).toList());
  }
}
