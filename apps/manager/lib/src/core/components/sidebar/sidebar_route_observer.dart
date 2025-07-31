import 'package:flutter/material.dart';

import 'package:manager/src/core/components/sidebar/sidebar.dart';

class SidebarRouteObserver extends NavigatorObserver {
  final SidebarController sidebarController;
  SidebarRouteObserver({required this.sidebarController});

  @override
  void didPop(Route route, Route? previousRoute) {
    sidebarController.emit();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    sidebarController.emit();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    sidebarController.emit();
  }
}
