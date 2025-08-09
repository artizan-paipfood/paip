import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PTabBarSimpleComponent extends StatelessWidget {
  final List<PTabSelectorWidget> children;

  const PTabBarSimpleComponent({
    super.key,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          decoration:
              BoxDecoration(color: context.color.primaryBG, borderRadius: PSize.i.borderRadiusAll, border: Border.all(color: context.color.border)),
          child: Row(
            children: children.map((e) => Expanded(child: e)).toList(),
          ),
        ),
        PSize.ii.sizedBoxH,
      ],
    );
  }
}

class PTabSelectorWidget extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final bool isSelected;

  const PTabSelectorWidget({
    super.key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? context.color.black : Colors.transparent,
      borderRadius: PSize.i.borderRadiusAll,
      child: InkWell(
        borderRadius: PSize.i.borderRadiusAll,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium?.copyWith(color: isSelected ? context.color.white : context.color.black),
          ),
        ),
      ),
    );
  }
}
