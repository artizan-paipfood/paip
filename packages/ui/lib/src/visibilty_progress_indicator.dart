import 'package:flutter/material.dart';

class UiVisibilityProgressIndicator extends StatelessWidget {
  final Widget child;
  final bool visibility;
  final Color color;

  const UiVisibilityProgressIndicator({
    super.key,
    required this.child,
    required this.visibility,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !visibility,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        ),
        if (visibility)
          SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                strokeCap: StrokeCap.round,
                color: color,
              )),
      ],
    );
  }
}
