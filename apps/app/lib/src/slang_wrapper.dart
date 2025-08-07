import 'package:ui/i18n/gen/strings.g.dart' as ui;
import 'package:i18n/i18n/gen/strings.g.dart' as i18n;
import 'package:auth/i18n/gen/strings.g.dart' as auth;
import 'package:address/i18n/gen/strings.g.dart' as address;
import 'package:app/i18n/gen/strings.g.dart';
import 'package:app/src/app_widget.dart';
import 'package:flutter/material.dart';

class SlangWrapperAppWidget extends StatelessWidget {
  const SlangWrapperAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return //
        TranslationProvider(child: ui.TranslationProvider(child: i18n.TranslationProvider(child: auth.TranslationProvider(child: address.TranslationProvider(child: AppWidget())))));
  }
}
