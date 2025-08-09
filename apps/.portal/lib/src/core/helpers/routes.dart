import 'package:core/core.dart';

class Routes {
  Routes._();

  static const String changelogProjectParam = "changelog_project";

  //*HOME
  static const String homeModule = "/";

  static const String homeRelative = "/";
  static String home = _normalizePath('/');

  static const String downloadsRelative = "/downloads";
  static String downloads = _normalizePath('/downloads');

  //*REGISTER
  static const String registerModule = "/register";

  static const String registerRelative = "/";
  static String register = _normalizePath('/register');

  static const String createEstablishmentStatusRelative = "/create_establishment_status";
  static String createEstablishmentStatus = _normalizePath('/register/create_establishment_status');

  //* AUTH
  static const String authModule = "/auth";

  static const String confirmEmailRelative = "/";
  static String confirmEmail = _normalizePath('/auth');

  static const String resetPasswordRelative = "/reset_password";
  static String resetPassword = _normalizePath('/auth/reset_password');

  //*POLICY
  static const String policyModule = "/policy";
  static const String policyGestorRelative = "/";
  static String policyGestor = _normalizePath('/policy');
  //*CHANGELOG
  static const String changelogModule = "/changelog";
  static const String changelogRelative = "/:$changelogProjectParam";
  static String changelog({required ChangelogProject project}) => _normalizePath("/$changelogModule/${project.name}");

  static String _normalizePath(String path) {
    // Remove barras extras no fim
    path = path.trim().replaceAll(RegExp(r'/+$'), '');

    // Substitui dois pontos por barra
    path = path.replaceAll(':', '/');

    // Substitui múltiplas barras por uma única barra, mantendo a barra inicial
    while (path.contains('//')) {
      path = path.replaceAll('//', '/');
    }

    return path;
  }
}
