import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/menu/aplication/usecases/get_menu_local_usecase.dart';
import 'package:manager/src/modules/menu/domain/models/image_menu_model.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CrudMenuLocalOrRestUsecase {
  final DataSource dataSource;
  final GetMenuLocalUsecase getMenuLocalUsecase;
  final GetMenuHttpUsecase getMenuHttpUsecase;
  final ILocalStorage localStorage;
  final IBucketRepository bucketRepo;
  CrudMenuLocalOrRestUsecase({
    required this.dataSource,
    required this.getMenuLocalUsecase,
    required this.getMenuHttpUsecase,
    required this.localStorage,
    required this.bucketRepo,
  });
  Future<void> call({required MenuDto menu, bool isLocal = false}) async {
    await localStorage.put(MenuDto.box, key: MenuDto.box, value: menu.toMap());

    await localStorage.get(MenuDto.box, key: MenuDto.box);

    //- IMAGENS

    if (isLocal == false) {
      final imagesTempRequest = await localStorage.getAll(ImageMenuModel.box);
      final imagesTemp = imagesTempRequest?.values.map((e) => ImageMenuModel.fromMap(e)).toList() ?? [];

      final List<ImageMenuModel> imagesDelete = [];

      if (imagesTemp.isNotEmpty) {
        final groupImagesTemp = imagesTemp.groupListsBy((element) => element.imageMenuType);

        for (var image in groupImagesTemp[ImageMenuType.product]?.toList() ?? <ImageMenuModel>[]) {
          if (menu.products[image.id] != null) {
            await localStorage.delete(ImageMenuModel.box, keys: [image.id]);
            continue;
          }
          imagesDelete.add(image);
        }
        for (var image in groupImagesTemp[ImageMenuType.item]?.toList() ?? <ImageMenuModel>[]) {
          if (menu.items[image.id] != null) {
            await localStorage.delete(ImageMenuModel.box, keys: [image.id]);
            continue;
          }
          imagesDelete.add(image);
        }
      }

      if (imagesDelete.isNotEmpty) {
        await localStorage.delete(ImageMenuModel.box, keys: imagesDelete.map((e) => e.id).toList());
        await Future.wait(imagesDelete.map((e) => bucketRepo.deletefile(e.path)).toList());
      }
    }
  }
}
