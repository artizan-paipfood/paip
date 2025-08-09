import 'dart:async';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/aplication/usecases/create_category_pizza_default_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/delete_images_item_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/get_menu_local_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/get_menu_vm_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/rebase_menu_local_storage_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/sync_menu_usecase.dart';
import 'package:manager/src/modules/menu/presenters/pages/menu_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class MenuModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => ProductsRepository(http: i.get())),
        Bind.factory((i) => CategoriesRepository(http: i.get())),
        Bind.factory((i) => SizesRepository(http: i.get())),
        Bind.factory((i) => ComplementsRepository(http: i.get())),
        Bind.factory((i) => ItemsRepository(http: i.get())),
        Bind.factory((i) => GetMenuHttpUsecase(establishmentRepo: i.get())),
        Bind.factory((i) => GetMenuLocalUsecase(localStorage: i.get())),
        Bind.factory((i) => RebaseMenuLocalStorageUsecase(localStorage: i.get())),
        Bind.factory((i) => GetMenuVmUsecase(dataSource: i.get(), getMenuLocalUsecase: i.get(), getMenuHttpUsecase: i.get(), localStorage: i.get(), bucketRepo: i.get(), rebaseMenuLocalStorageUsecase: i.get())),
        Bind.factory((i) => DeleteImagesUsecase(bucketRepo: i.get())),
        Bind.factory((i) => CreateCategoryPizzaDefaultUsecase(dataSource: i.get())),
        Bind.factory((i) => SyncMenuUsecase(productRepo: i.get(), categoryRepo: i.get(), complementRepo: i.get(), sizeRepo: i.get(), itemRepo: i.get(), getMenuDatasourceUsecase: i.get(), getRestMenuUsecase: i.get(), bucketRepo: i.get())),
        Bind.singleton((i) => MenuStore(dataSource: i.get(), bucketRepo: i.get(), syncMenuUsecase: i.get(), getMenuDatasourceUsecase: i.get(), localStorage: i.get(), deleteImagesUsecase: i.get(), createCategoryPizzaDefaultUsecase: i.get()))
      ];

  @override
  List<ModularRoute> get routes => [ChildRoute(Routes.menuRelative, child: (context, args) => const MenuPage())];
}
