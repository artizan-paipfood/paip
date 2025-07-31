enum RouteType {
  route,
  moduleR,
  childR;
}

class RouteModel {
  String moduleR;
  String childR;
  String route;
  List<String> params;
  Duration? d;

  RouteModel({
    required this.moduleR,
    required this.childR,
    required this.route,
    this.params = const [],
    this.d = const Duration(milliseconds: 700),
  });
  String rroute({List<String>? params}) {
    return "$route${params!.join("/")}";
  }

  static RouteModel buildRouteModular({required String module, required String routeName, List<String> params = const []}) {
    final args_ = params.map((e) => ":$e").join("/");
    return RouteModel(route: _buildPath("/$module/$routeName"), moduleR: _buildPath("/$module"), childR: _buildPath("/$routeName/$args_"));
  }

  static String _buildPath(String path) {
    String cleanedPath = path.replaceAll(RegExp(r'/+'), '/');
    if (cleanedPath.endsWith('/')) {
      cleanedPath = cleanedPath.substring(0, cleanedPath.length - 1);
    }
    return cleanedPath.isNotEmpty ? cleanedPath : '/';
  }
}
