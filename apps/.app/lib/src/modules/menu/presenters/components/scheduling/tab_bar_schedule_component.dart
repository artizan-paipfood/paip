import 'package:flutter/material.dart';

import 'package:app/src/modules/menu/presenters/components/p_tab_bar_simple_component.dart';
import 'package:app/src/modules/menu/presenters/components/scheduling/scheduling_controller.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TabBarScheaduleComponent extends StatefulWidget {
  final SchedulingController controller;
  final void Function(HoursEnum hour) onSelect;
  final void Function(int weekDay) onSelectWeekDay;
  final HoursEnum? hourSelected;
  final int weekDay;
  const TabBarScheaduleComponent({
    required this.controller,
    required this.onSelect,
    required this.onSelectWeekDay,
    required this.weekDay,
    super.key,
    this.hourSelected,
  });

  @override
  State<TabBarScheaduleComponent> createState() => _TabBarScheaduleComponentState();
}

class _TabBarScheaduleComponentState extends State<TabBarScheaduleComponent> {
  @override
  Widget build(BuildContext context) {
    final hoursEnable = widget.controller.getHoursEnableByWeekday(widget.weekDay);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.controller.enableTabBar)
          PTabBarSimpleComponent(children: [
            PTabSelectorWidget(
                label: 'Hoje',
                isSelected: widget.weekDay == widget.controller.getToDay,
                onTap: () {
                  widget.onSelectWeekDay(widget.controller.getToDay);
                }),
            PTabSelectorWidget(
                label: 'Amanhã',
                isSelected: widget.weekDay == widget.controller.getTomorow,
                onTap: () {
                  widget.onSelectWeekDay(widget.controller.getTomorow);
                }),
          ]),
        PSize.ii.sizedBoxH,
        Visibility(
          visible: hoursEnable.isNotEmpty,
          replacement: const CwEmptyState(size: 180, icon: PIcons.strokeRoundedDropbox, label: 'Nenhum horário disponível', bgColor: false),
          child: Wrap(
            spacing: PSize.ii.value,
            runSpacing: PSize.ii.value,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: hoursEnable.map((time) {
              final isSelected = (widget.hourSelected == time);
              return SizedBox(
                width: 65,
                child: Material(
                    color: isSelected ? context.color.black : Colors.transparent,
                    borderRadius: PSize.i.borderRadiusAll,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: () => widget.onSelect(
                        time,
                      ),
                      child: Ink(
                          decoration: BoxDecoration(border: Border.all(color: context.color.border), borderRadius: PSize.i.borderRadiusAll),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Text(time.label, textAlign: TextAlign.center, style: context.textTheme.bodyMedium?.copyWith(color: isSelected ? context.color.white : context.color.black)),
                          )),
                    )),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
