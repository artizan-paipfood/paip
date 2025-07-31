import 'package:paipfood_package/paipfood_package.dart';

class PImageBucket {
  static String _generate(String imageName, {String? ext = ".png"}) {
    return '$imageName$ext'.buildPublicUriBucket;
  }

  static String get emptyLogoEstablishment => _generate("defaults/empty_logo_establishment");
  static String get emptyCam => _generate("defaults/empty_cam");
  static String get emptyBanner => _generate("defaults/empty_banner");
  static String get emptyitem => _generate("defaults/empty_item");
}
