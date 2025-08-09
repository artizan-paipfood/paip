import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class AppBarMobileHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  final void Function() onTapMenu;
  const AppBarMobileHomeWidget({
    super.key,
    required this.onTapMenu,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        ArtButton.outline(onPressed: () => onTapMenu(), leading: const Icon(PIcons.strokeRoundedMenu01)),
        PSize.ii.sizedBoxW,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
