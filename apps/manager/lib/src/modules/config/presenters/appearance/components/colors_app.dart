import 'package:flutter/material.dart';

import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/divider.dart';
import 'package:manager/src/modules/config/aplication/stores/aparence_store.dart';
import 'package:manager/src/modules/config/presenters/appearance/widgets/cw_color_selector.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ColorsApp extends StatefulWidget {
  const ColorsApp({super.key});

  @override
  State<ColorsApp> createState() => _ColorsAppState();
}

class _ColorsAppState extends State<ColorsApp> {
  late final store = context.read<AparenceStore>();
  @override
  Widget build(BuildContext context) {
    return CwContainerShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.i18n.cores, style: context.textTheme.titleLarge),
          const CwDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(context.i18n.corPrimaria, style: context.textTheme.labelLarge), Text(context.i18n.descCorPrimaria, style: context.textTheme.bodySmall)])),
              Expanded(
                flex: 2,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.end,
                  children: ThemeEnum.values
                      .map(
                        (theme) => CwColorSelector(
                          theme: theme,
                          isSelected: store.dataSource.company.theme == theme,
                          onTap: () {
                            setState(() {
                              store.changeTheme(theme);
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
