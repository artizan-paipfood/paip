import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CwSwitchActiveInative extends StatefulWidget {
  final bool isActive;
  final bool Function()? onTap;
  const CwSwitchActiveInative({required this.isActive, super.key, this.onTap});

  @override
  State<CwSwitchActiveInative> createState() => _CwSwitchActiveInativeState();
}

class _CwSwitchActiveInativeState extends State<CwSwitchActiveInative> {
  bool _isActive = false;
  @override
  void initState() {
    _isActive = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isActive = widget.onTap?.call() ?? _isActive;
        });
      },
      child: Container(
        width: 128,
        decoration: BoxDecoration(border: Border.all(color: _isActive ? context.color.primaryColor : context.color.errorColor), borderRadius: BorderRadius.circular(3)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ColoredBox(
                color: _isActive ? context.color.primaryColor.withOpacity(0.1) : context.color.errorColor,
                child: Center(child: Text(context.i18n.inativo, style: context.textTheme.bodyMedium!.copyWith(color: _isActive ? context.color.secondaryText : Colors.white)).center),
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: _isActive ? context.color.primaryColor : context.color.secondaryColor.withOpacity(0.1),
                child: Center(child: Text(context.i18n.ativo, style: context.textTheme.bodyMedium!.copyWith(color: _isActive ? context.color.primaryBG : context.color.secondaryText)).center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
