import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CardPayment extends StatefulWidget {
  final String label;
  final IconData icon;
  final String? description;
  final bool value;
  final void Function(bool value) onChanged;
  final void Function(Set<OrderTypeEnum> orderTypes) onOrderTypeChanged;
  final Widget? child;
  final Set<OrderTypeEnum> orderTypes;

  const CardPayment({
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
    required this.onOrderTypeChanged,
    required this.orderTypes,
    super.key,
    this.description,
    this.child,
  });

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  final Set<OrderTypeEnum> _orderTypesAvaliable = {OrderTypeEnum.delivery, OrderTypeEnum.takeWay};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: PSize.i.borderRadiusAll,
            border: Border.all(
              color: context.color.border,
            )),
        child: Padding(
          padding: PSize.i.paddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(widget.icon),
                      PSize.i.sizedBoxW,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.label,
                            style: context.textTheme.labelLarge,
                          ),
                          if (widget.description != null)
                            Text(
                              widget.description!,
                              style: context.textTheme.labelSmall?.copyWith(color: context.color.muted),
                            ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      PSize.i.sizedBoxW,
                      PSwicth(
                        value: widget.value,
                        onChanged: widget.onChanged,
                      ),
                    ],
                  )
                ],
              ),
              SegmentedButton<OrderTypeEnum>(
                  multiSelectionEnabled: true,
                  emptySelectionAllowed: true,
                  onSelectionChanged: (value) {
                    widget.onOrderTypeChanged(value);
                  },
                  style: SegmentedButton.styleFrom(
                      side: BorderSide(color: context.color.border),
                      shape: RoundedRectangleBorder(borderRadius: PSize.i.borderRadiusAll),
                      selectedBackgroundColor: context.color.primaryColor.withOpacity(0.2),
                      selectedForegroundColor: context.color.primaryColor,
                      shadowColor: Colors.blue),
                  segments: _orderTypesAvaliable
                      .map(
                        (e) => ButtonSegment(
                          value: e,
                          label: Text(
                            e.i18nText.i18n(),
                          ),
                        ),
                      )
                      .toList(),
                  selected: widget.orderTypes),
              if (widget.child != null) ...[Divider(color: context.color.border), widget.child!],
            ],
          ),
        ),
      ),
    );
  }
}
