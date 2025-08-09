import 'package:flutter/material.dart';
import 'package:manager/src/core/components/sidebar/sidebar.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ButtonHideNavbarWidget extends StatefulWidget {
  final Color? backgroundColor;
  final Color? iconColor;

  const ButtonHideNavbarWidget({
    super.key,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  State<ButtonHideNavbarWidget> createState() => _ButtonHideNavbarWidgetState();
}

class _ButtonHideNavbarWidgetState extends State<ButtonHideNavbarWidget> {
  final SidebarController navController = SidebarController.instance;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: navController,
        builder: (context, _) {
          return IconButton.filled(
            style: IconButton.styleFrom(backgroundColor: widget.backgroundColor ?? context.color.onPrimaryBG),
            onPressed: () {
              navController.toggleHide();
              //hide
            },
            icon: Icon(navController.isHide ? PIcons.strokeRoundedArrowRight01 : PIcons.strokeRoundedArrowLeft01),
            color: widget.iconColor ?? context.color.primaryText,
          );
        });
  }
}
