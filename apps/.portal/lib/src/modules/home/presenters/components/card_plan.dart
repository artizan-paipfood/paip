import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/modules/home/domain/plans_dto.dart';
import 'package:ui/ui.dart';

class CardPlan extends StatefulWidget {
  final PlansModel plan;
  final bool isSelected;
  final Function(PlansModel plan)? onSelected;

  const CardPlan({super.key, required this.plan, required this.onSelected, this.isSelected = false});

  @override
  State<CardPlan> createState() => _CardPlanState();
}

class _CardPlanState extends State<CardPlan> {
  Color get _textColor => widget.isSelected ? context.color.primaryBG : context.color.primaryText;
  late final dto = PlansDto(context: context, plan: widget.plan);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 285, minWidth: 250),
      child: ArtCard(
        backgroundColor: widget.isSelected ? context.artColorScheme.foreground : context.artColorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("✨", style: TextStyle(fontSize: 20)),
            PSize.ii.sizedBoxH,
            Text(dto.title, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: _textColor)),
            Text(dto.description, style: context.textTheme.bodyMedium?.muted(context)),
            PSize.i.sizedBoxH,
            RichText(text: TextSpan(children: [TextSpan(text: dto.price, style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: _textColor)), TextSpan(text: " ${context.i18n.porMes}", style: context.textTheme.bodyMedium?.muted(context))])),
            PSize.i.sizedBoxH,
            Divider(color: context.color.border),
            PSize.i.sizedBoxH,
            Text(context.i18n.funcionalidades, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: _textColor)),
            ...dto.buildFeatures(context),
            PSize.ii.sizedBoxH,
            Row(
              children: [
                Expanded(
                  child: ArtButton(
                    backgroundColor: widget.isSelected ? context.artColorScheme.background : null,
                    foregroundColor: widget.isSelected ? context.artColorScheme.foreground : null,
                    child: Text(context.i18n.selecionar.toUpperCase()),
                    onPressed: () {
                      widget.onSelected?.call(widget.plan);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
