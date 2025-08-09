import 'package:ui/ui.dart' as ui;
import 'package:i18n/i18n.dart' as i18n;
import 'package:auth/auth.dart' as auth;
import 'package:address/address.dart' as address;
import 'package:explore/explore.dart' as explore;
import 'package:app/src/_i18n/gen/strings.g.dart';
import 'package:app/src/app_widget.dart';
import 'package:flutter/material.dart';

class SlangWrapperAppWidget extends StatelessWidget {
  const SlangWrapperAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return //
        TranslationProvider(child: ui.TranslationProvider(child: i18n.TranslationProvider(child: auth.TranslationProvider(child: address.TranslationProvider(child: explore.TranslationProvider(child: AppWidget()))))));
  }
}
