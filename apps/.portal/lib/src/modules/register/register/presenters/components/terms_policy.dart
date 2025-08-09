import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';

class TermsPolicy extends StatelessWidget {
  const TermsPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.artTextTheme;
    return Container(
      decoration: BoxDecoration(color: context.artColorScheme.muted, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: context.i18n.callTermosUso, style: textTheme.small),
              TextSpan(
                text: context.i18n.termosUso,
                style: textTheme.muted.copyWith(color: context.color.secondaryColor, decoration: TextDecoration.underline, decorationColor: context.color.secondaryColor),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              TextSpan(text: " ${context.i18n.e} ", style: textTheme.small),
              TextSpan(
                text: "${context.i18n.politicaPrivacidade}.",
                style: textTheme.muted.copyWith(color: context.color.secondaryColor, decoration: TextDecoration.underline, decorationColor: context.color.secondaryColor),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
