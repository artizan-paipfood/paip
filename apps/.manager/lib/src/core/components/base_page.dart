import 'package:flutter/material.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/inner_container.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final Widget header;
  final bool compact;
  const BasePage({
    required this.child,
    required this.header,
    this.compact = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CwContainerShadow(
        child: Column(
          children: [
            header,
            Expanded(
              child: CwInnerContainer(
                width: double.infinity,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
