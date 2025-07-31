import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Phone Dial Code Selector', type: PhoneDialCodeSelector, path: 'i18n')
Widget primaryButton(BuildContext context) {
  return Scaffold(body: Center(child: PhoneDialCodeSelector()));
}
