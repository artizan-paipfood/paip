import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwDialog extends StatelessWidget {
  final MainAxisAlignment? actionsAlignment;
  final List<Widget>? actions;
  final Widget? title;
  final Widget? content;
  final bool canPop;

  const CwDialog({
    super.key,
    this.actionsAlignment,
    this.actions,
    this.title,
    this.content,
    this.canPop = true,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: AlertDialog(
        actions: actions,
        actionsAlignment: actionsAlignment,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title != null ? title! : const SizedBox.shrink(),
            PSize.iii.sizedBoxW,
            if (canPop)
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
          ],
        ),
        content: content,
      ),
    );
  }
}
