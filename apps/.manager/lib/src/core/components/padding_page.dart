import 'package:flutter/material.dart';

class CwPaddingPage extends StatelessWidget {
  final Widget child;

  const CwPaddingPage({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      child: child,
    );
  }
}
