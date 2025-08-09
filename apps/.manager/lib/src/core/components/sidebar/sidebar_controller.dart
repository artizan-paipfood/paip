part of 'sidebar.dart';

class SidebarController extends ChangeNotifier {
  static SidebarController? _instance;
  SidebarController._();
  static SidebarController get instance => _instance ??= SidebarController._();
  //
  bool _isCollapsed = true;
  bool get isCollapsed => _isCollapsed;

  bool _isHide = false;
  bool get isHide => _isHide;

  String _menu = '';
  String get menu => _menu;

  bool menuIsSelected(BuildContext context, {required String id}) {
    final path = GoRouterState.of(context).uri.toString();
    return path.contains(id);
  }

  bool menuIsExpanded(BuildContext context, {required String id}) {
    if (!isCollapsed) return false;
    // final path = GoRouterState.of(context).uri.toString();
    return _menu.toLowerCase().trimLeft() == id.toLowerCase().trim();
  }

  bool subMenuIsSelected(BuildContext context, {required String id}) {
    final path = GoRouterState.of(context).uri.toString();
    return path.contains(id);
  }

  void toggleCollapse() {
    _isCollapsed = !_isCollapsed;
    notifyListeners();
  }

  void toggleMenu({required String id, bool containSubmenus = false}) {
    if (_menu == id) {
      _menu = '';
    } else {
      _menu = id;
    }
    notifyListeners();
  }

  void toggleHide() {
    _isHide = !_isHide;
    notifyListeners();
  }

  void emit() {
    notifyListeners();
  }
}
