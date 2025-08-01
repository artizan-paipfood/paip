class Images {
  Images._();

  static String _assets(String fileName, {String? extension = 'png'}) => 'assets/images/$fileName.$extension';

  static String get loginOnboarding => _assets('login-onboarding', extension: 'jpg');
}

class SvgImages {
  SvgImages._();

  static String _assets(String fileName) => 'assets/images/$fileName.svg';

  static String get logoLight => _assets('logo-light');
}
