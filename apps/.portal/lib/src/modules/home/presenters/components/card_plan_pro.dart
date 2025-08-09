import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/modules/home/domain/plans_dto.dart';
import 'package:portal/src/modules/home/presenters/components/card_plan.dart';
import 'package:ui/ui.dart';

class CardPlanPro extends StatefulWidget {
  final PlansModel plan;
  final bool isSelected;
  final Function(PlansModel plan)? onSelected;

  const CardPlanPro({super.key, required this.plan, this.isSelected = false, required this.onSelected});

  @override
  State<CardPlanPro> createState() => _CardPlanProState();
}

class _CardPlanProState extends State<CardPlanPro> {
  late final dto = PlansDto(context: context, plan: widget.plan);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.artColorScheme;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: CardPlan(
            plan: widget.plan,
            isSelected: widget.isSelected,
            onSelected: widget.onSelected,
          ),
        ),
        Positioned(
          top: 16,
          right: -2,
          child: Container(
            decoration: BoxDecoration(color: colorScheme.ring, borderRadius: 0.5.borderRadiusAll),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Text('Popular', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
