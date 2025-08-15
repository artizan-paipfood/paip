class Routes {
  Routes._();
  // ONBOARDING
  static const String onboardingModule = '/';

  static const String onboardingRelative = '/';
  static const String onboardingNamed = 'onboarding';
  static const String onboarding = '/';

  // AUTH
  static const String authModule = '/auth';

  static const String authUserName = authModule;

  // ADDRESS
  static const String addressModule = '/address';

  static const String myAddresses = addressModule;
  static const String addressAutoComplete = '$addressModule/auto-complete';
  static const String addressManually = '$addressModule/manually';

  // EXPLORE
  static const String exploreModule = '/explore';
  static const String explore = '/explore';

  //STORE
  static const String storeModule = '/store';
  static String store(String establishmentId) => '/store/$establishmentId';

  // CART
  static const String cartModule = '/cart';
  static String cartProduct(String productId) => '/cart/$productId';
}
