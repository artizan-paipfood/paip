import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/table/presenter/components/p_toggle_nivel_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class HeaderTableAndOrderComponent extends StatefulWidget {
  final void Function() onTapTables;
  final void Function() onTapCommand;

  final bool isTableView;
  const HeaderTableAndOrderComponent({required this.onTapTables, required this.onTapCommand, required this.isTableView, super.key});

  @override
  State<HeaderTableAndOrderComponent> createState() => _HeaderTableAndOrderComponentState();
}

class _HeaderTableAndOrderComponentState extends State<HeaderTableAndOrderComponent> {
  PToggleNivelStyle get _headerDarkStyle => PToggleNivelStyle(textColor: PColors.light.white, selectedTextColor: PColors.light.white, backgroundColor: PColors.light.neutral900, selectedBackgroundColor: PColors.light.neutral800, selectedHoverColor: PColors.light.neutral950);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: PColors.light.neutral900,
          width: double.infinity,
          child: Padding(
            padding: PSize.i.paddingHorizontal + PSize.ii.paddingTop,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.only(right: 8), child: PToggleNivelWidget(isSelected: widget.isTableView, label: context.i18n.mesas, onTap: widget.onTapTables, style: _headerDarkStyle)),
                Padding(padding: const EdgeInsets.only(right: 8), child: PToggleNivelWidget(isSelected: widget.isTableView == false, label: context.i18n.comandas, onTap: widget.onTapCommand, style: _headerDarkStyle)),
                PSize.ii.sizedBoxW,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
