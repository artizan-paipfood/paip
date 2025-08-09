import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class StepBar extends StatelessWidget {
  final List<String> steps;
  final ValueNotifier<int> currentStep;

  const StepBar({
    super.key,
    this.steps = const [],
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: steps
            .map((e) => Steps(
                  currentStep: currentStep.value,
                  step: steps.indexOf(e),
                  label: e,
                  padding: steps.indexOf(e) != steps.length - 1,
                  isFinish: steps.indexOf(e) == steps.length - 1,
                ))
            .toList());
  }
}

class Steps extends StatelessWidget {
  final String label;
  final int step;
  final int currentStep;
  final bool padding;
  final bool isFinish;

  const Steps({
    super.key,
    required this.label,
    required this.step,
    required this.currentStep,
    this.padding = true,
    this.isFinish = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: padding ? const EdgeInsets.only(right: 8) : EdgeInsets.zero,
      child: Column(
        children: [
          Text(step != currentStep ? "" : label, style: context.textTheme.titleMedium),
          PSize.i.sizedBoxH,
          SizedBox(
            width: step != currentStep ? null : label.length * 9,
            child: LinearProgressIndicator(
              minHeight: 7,
              borderRadius: PSize.i.borderRadiusAll,
              color: () {
                if (step == currentStep) return context.color.primaryColor;
                if (step > currentStep) return context.color.onPrimaryBG;
              }(),
              backgroundColor: context.color.onPrimaryBG,
              value: (step != currentStep || isFinish) ? 1 : null,
            ),
          ),
        ],
      ),
    );
    return step != currentStep ? Expanded(child: child) : child;
  }
}
