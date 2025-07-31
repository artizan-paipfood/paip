class PImages {
  static String _generate(String imageName, {String? ext = ".png"}) {
    return 'assets/images/$imageName$ext';
  }

  static String get login => _generate("login_image", ext: ".jpg");
  static String get logoDark => _generate("logo_dark", ext: ".svg");
  static String get shop3d => _generate("shop_3d", ext: ".png");
}
