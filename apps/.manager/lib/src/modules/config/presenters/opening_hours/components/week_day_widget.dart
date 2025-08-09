import 'package:flutter/material.dart';

import 'package:manager/src/modules/config/aplication/stores/opening_hours_store.dart';
import 'package:manager/src/modules/config/presenters/opening_hours/components/dialog_edit_opening_hours.dart';
import 'package:paipfood_package/paipfood_package.dart';

class WeekDayWidget extends StatefulWidget {
  final List<OpeningHoursModel> opingHours;
  final String label;
  final bool showHours;
  const WeekDayWidget({
    required this.label,
    super.key,
    this.opingHours = const [],
    this.showHours = false,
  });

  @override
  State<WeekDayWidget> createState() => _WeekDayWidgetState();
}

class _WeekDayWidgetState extends State<WeekDayWidget> {
  late final store = context.read<OpeningStore>();
  final padding = const EdgeInsets.symmetric(horizontal: 3);
  final colorSelected = PColors.tertiaryDColor_;

  void _edit(BuildContext context, {required OpeningHoursModel model}) {
    showDialog(
        context: context,
        builder: (context) => DialogEditOpeningHours(
              model: model,
              store: store,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final List<OpeningHoursModel> opingHoursSelecteds = [];
    return Column(
      children: [
        Text(
          widget.label,
          style: context.textTheme.labelLarge,
        ),
        PSize.ii.sizedBoxH,
        Column(children: [
          ...HoursEnum.values.map(
            (hourEnum) {
              final int index = HoursEnum.values.indexOf(hourEnum);

              final openingHourModel = widget.opingHours.firstWhereOrNull(
                (model) => model.openingEnumValue.value <= hourEnum.value && model.closingEnumValue.value >= hourEnum.value,
              );
              final isSelected = openingHourModel != null;

              if (index % 4 == 0) {
                return Padding(
                  padding: padding,
                  child: Material(
                    color: isSelected ? colorSelected : Colors.transparent,
                    child: InkWell(
                      onTap: isSelected ? () => _edit(context, model: openingHourModel) : null,
                      child: SizedBox(
                        height: 16,
                        width: double.infinity,
                        child: Text(
                          () {
                            if (widget.showHours) return hourEnum.label;
                            if (isSelected && !opingHoursSelecteds.contains(openingHourModel)) {
                              opingHoursSelecteds.add(openingHourModel);
                              return "${openingHourModel.openingEnumValue.label} - ${openingHourModel.closingEnumValue.label}";
                            }

                            return "";
                          }(),
                          textAlign: isSelected ? TextAlign.center : null,
                          style: context.textTheme.labelLarge?.copyWith(color: isSelected ? Colors.black : context.color.primaryText),
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (index % 2 == 0) {
                return InkWell(
                  onTap: isSelected ? () => _edit(context, model: openingHourModel) : null,
                  child: DecoratedBox(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.color.neutral300))),
                    child: Padding(
                      padding: padding,
                      child: Container(
                        height: 16,
                        decoration: BoxDecoration(color: isSelected ? colorSelected : Colors.transparent, border: Border(bottom: BorderSide(color: context.color.neutral300))),
                      ),
                    ),
                  ),
                );
              }

              return InkWell(
                onTap: isSelected ? () => _edit(context, model: openingHourModel) : null,
                child: Padding(
                  padding: padding,
                  child: Container(
                    height: 16,
                    color: isSelected ? colorSelected : Colors.transparent,
                  ),
                ),
              );
            },
          ),
          PSize.i.sizedBoxH
        ]),
      ],
    );
  }
}
