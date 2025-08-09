import '../stores/register_store.dart';
import 'navigation_to_usecase.dart';

class BackPageUsecase {
  RegisterStore store;
  BackPageUsecase({required this.store});

  call() {
    store.pageIndexVN.value--;
    NavigationToUsecase(pageController: store.pageController).call(index: store.pageIndexVN.value);
  }
}
