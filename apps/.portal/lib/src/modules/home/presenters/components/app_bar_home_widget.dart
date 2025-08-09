import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/core/helpers/routes.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.artColorScheme.background,
      surfaceTintColor: context.artColorScheme.background.withValues(alpha: .4),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(children: [Text(context.i18n.funcionalidades, style: context.textTheme.bodyMedium?.muted(context)), PSize.spacer.sizedBoxW, Text(context.i18n.planosEprecos, style: context.textTheme.bodyMedium?.muted(context))]),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ArtButton.outline(child: Text(context.i18n.download)),
              PSize.spacer.sizedBoxW,
              ArtButton(
                child: Text(context.i18n.login),
                onPressed: () {
                  context.push(Routes.register);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
