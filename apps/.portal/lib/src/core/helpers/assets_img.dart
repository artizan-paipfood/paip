class Assets {
  Assets._();

  static String _get({required String path, String? ext}) => "assets/images/$path${ext ?? ".png"}";

  static String getIcon(String path) => "assets/icons/$path";

  static String get confete => _get(path: 'confete');

  /// [light404] is GIF
  static String get light404 => _get(path: '404_light', ext: '.gif');

  /// [dark404] is GIF
  static String get dark404 => _get(path: '404_dark', ext: '.gif');

  /// [pdvHome] is JPG
  static String get pdvHome => _get(path: 'pdv_home', ext: ".jpg");
  static String get deliveryPatinet => _get(path: 'delivery-patinet', ext: ".jpg");

  /// [logoWhite] is SVG
  static String get logoWhite => _get(path: 'logo-white', ext: ".svg");

  /// [logoGreenLghtWhite] is SVG
  static String get logoGreenWhite => _get(path: 'logo-green-white', ext: ".svg");

  /// [logoGreenLghtBlack] is SVG
  static String get logoGreenBlack => _get(path: 'logo-green-black', ext: ".svg");

  /// [bannerResetPassword] is JPG
  static String get bannerResetPassword => _get(path: 'banner_reset_password', ext: ".jpg");
}
