import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/modules/home/presenters/components/card_plan.dart';
import 'package:portal/src/modules/home/presenters/components/card_plan_pro.dart';

class PlansComponent extends StatelessWidget {
  final List<PlansModel> plans;
  final Function(PlansModel plan) onSelected;
  const PlansComponent({super.key, this.plans = const [], required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PSize.v.sizedBoxH,
        Text(context.i18n.planosTitle, style: context.artTextTheme.h2, textAlign: TextAlign.center),
        PSize.v.sizedBoxH,
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 20,
          spacing: 20,
          children: plans.map((p) {
            if (p.plan == Plans.pro) return CardPlanPro(plan: p, isSelected: true, onSelected: (plan) => onSelected.call(plan));
            return CardPlan(plan: p, isSelected: false, onSelected: (plan) => onSelected.call(plan));
          }).toList(),
        ),
        PSize.viii.sizedBoxH,
      ],
    );
  }
}
