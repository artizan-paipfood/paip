import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

import 'package:manager/src/modules/config/domain/dtos/user_preferences_dto.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/user_preferences_viewmode.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwDialogEndDrawer extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final double widthFactor;

  const CwDialogEndDrawer({
    required this.child,
    super.key,
    this.backgroundColor,
    this.widthFactor = 0.5,
  });

  @override
  State<CwDialogEndDrawer> createState() => _CwDialogEndDrawerState();
}

class _CwDialogEndDrawerState extends State<CwDialogEndDrawer> with SingleTickerProviderStateMixin {
  late final animateController = AnimationController(vsync: this);
  late final userPreferencesViewmodel = context.read<UserPreferencesViewmodel>();

  bool get _rightHanded => userPreferencesViewmodel.userPreferences.handMode == HandMode.rightHanded;
  @override
  void dispose() {
    animateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        await animateController.reverse();
        return true;
      },
      child: Align(
        alignment: () {
          if (isAndroid) {
            return _rightHanded ? Alignment.centerLeft : Alignment.centerRight;
          }
          return _rightHanded ? Alignment.centerRight : Alignment.centerLeft;
        }(),
        child: FractionallySizedBox(
          heightFactor: 1.0,
          widthFactor: widget.widthFactor,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: PColors.light.primaryColor, width: 2),
              ),
            ),
            child: Material(
              color: context.color.primaryBG,
              child: Scaffold(backgroundColor: widget.backgroundColor ?? context.color.primaryBG, body: widget.child),
            ),
          ),
        ).animate(controller: animateController).moveX(begin: (_rightHanded ? 5000 : -5000) * 0.5, end: 0, curve: Curves.fastEaseInToSlowEaseOut, duration: 500.ms),
      ),
    );
  }
}
