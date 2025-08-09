class PImages {
  static String _generate(String imageName, {String? ext = ".png"}) {
    return 'assets/images/$imageName$ext';
  }

  static String get logoNameHorizontalLight => _generate("logo-name-horizontal", ext: ".svg");
  static String get logoNameHorizontalDark => _generate("logo-name-horizontal-dark", ext: ".svg");
  static String get logoNameVerticalLight => _generate("logo-name-vertical", ext: ".svg");
  static String get logoNameVerticalDark => _generate("logo-name-vertical-dark", ext: ".svg");
  static String get logo => _generate("logo", ext: ".svg");
  static String get logoSumup => _generate("sunmup");
  static String get logoHipay => _generate("hipay");
  static String get logoStripe => _generate("stripe");
  static String get loginBanner => _generate("login-banner");
  static String get product => _generate("products");
  static String get flavorPizza => _generate("flavor_pizza");
  static String get shop3d => _generate("shop_3d");
  static String get mercadoPago => _generate("mercado_pago", ext: ".svg");
}

class PSounds {
  static String _generate(String fileName, {String? ext = ".mp3"}) {
    return 'sounds/$fileName$ext';
  }

  static String get alert => _generate("sound_alert");
  static String get alertOpenEstablishment => _generate("alert_open_establishment", ext: ".wav");
  static String get notification => _generate("notification", ext: ".wav");
  static String get popTone => _generate("pop_tone", ext: ".wav");
}

class PLotties {
  PLotties._();
  static String _generate(String fileName, {String? ext = ".json"}) {
    return 'assets/lotties/$fileName$ext';
  }

  static String get download => _generate("lottie_download");
}
