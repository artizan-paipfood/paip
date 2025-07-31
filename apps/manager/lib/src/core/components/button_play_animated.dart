import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ButtonPlayAnimated extends StatefulWidget {
  const ButtonPlayAnimated({super.key});

  @override
  State<ButtonPlayAnimated> createState() => _ButtonPlayAnimatedState();
}

class _ButtonPlayAnimatedState extends State<ButtonPlayAnimated> with TickerProviderStateMixin {
  bool _isHover = false;
  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) => setState(() {
        if (value) {
          color = context.color.errorColor.withOpacity(0.1);
        }
        if (!value) {
          color = Colors.transparent;
        }
        _isHover = value;
      }),
      child: AnimatedContainer(
        duration: 1.seconds,
        curve: Curves.bounceInOut,
        decoration: BoxDecoration(color: color, borderRadius: 0.5.borderRadiusAll, border: Border.all(color: _isHover ? context.color.errorColor : Colors.transparent, width: 1.5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Row(
            children: [
              Icon(
                PaipIcons.youtube,
                color: context.color.errorColor,
                size: 18,
              ).animate().scale(duration: 600.ms, curve: Curves.easeInBack, begin: const Offset(0.98, 0.98), end: const Offset(1.5, 1.5)).then().scale(duration: 600.ms, curve: Curves.easeInBack, begin: const Offset(1.5, 1.5), end: const Offset(1, 1)),
              PSize.i.sizedBoxW,
              Text(context.i18n.tutorial, style: context.textTheme.bodyMedium?.copyWith()).animate().fade(delay: 500.ms, duration: 1500.ms, curve: Curves.ease),
            ],
          ),
        ),
      ),
    );
  }
}
