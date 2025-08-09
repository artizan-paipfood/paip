import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CardPaymentTypeOrder extends StatefulWidget {
  final PaymentType paymentType;
  final bool isSelected;
  final void Function() onTap;

  const CardPaymentTypeOrder({
    required this.paymentType,
    required this.onTap,
    super.key,
    this.isSelected = false,
  });

  @override
  State<CardPaymentTypeOrder> createState() => _CardPaymentTypeOrderState();
}

class _CardPaymentTypeOrderState extends State<CardPaymentTypeOrder> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: 0.5.borderRadiusAll,
      onHover: (value) => setState(() => _isHover = value),
      onTap: widget.onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: () {
            if (widget.isSelected) return context.color.primaryColor;
            if (_isHover) return context.color.primaryColor.withOpacity(0.5);
            return context.color.neutral300;
          }(),
          borderRadius: 0.5.borderRadiusAll,
        ),
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8) + PSize.i.paddingTop + 0.5.paddingBottom,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.paymentType.icon,
                  color: widget.isSelected ? Colors.white : null,
                ),
                PSize.i.sizedBoxW,
                Text(widget.paymentType.name.i18n().toUpperCase(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: widget.isSelected ? Colors.white : null,
                    )).center,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
