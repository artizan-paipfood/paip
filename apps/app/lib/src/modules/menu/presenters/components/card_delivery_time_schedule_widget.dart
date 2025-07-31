import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardDeliveryTimeScheduleWidget extends StatelessWidget {
  final MenuViewmodel store;
  final void Function() onTap;
  final bool isSelected;

  const CardDeliveryTimeScheduleWidget({required this.onTap, required this.isSelected, required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        borderRadius: PSize.i.borderRadiusAll,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: context.color.primaryColor,
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(borderRadius: PSize.i.borderRadiusAll, color: context.color.primaryBG, border: Border.all(color: isSelected ? context.color.primaryColor : context.color.neutral300, width: isSelected ? 2 : 1)),
            child: Padding(
              padding: PSize.i.paddingAll,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(context.i18n.agendar)]),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(store.orderViewmodel.order.scheduleDate == null ? context.i18n.selecioneUmHorario : store.orderViewmodel.order.buildScheduleTimeIntervalFormated(context), style: context.textTheme.bodySmall?.muted(context), maxLines: 2)],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
