import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manager/src/modules/config/presenters/preferences/components/card_envoriments.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CardSwitch extends StatefulWidget {
  final String label;
  final bool value;
  final void Function(bool value) onChanged;
  final String description;
  const CardSwitch({
    required this.onChanged,
    super.key,
    this.label = '',
    this.value = false,
    this.description = '',
  });

  @override
  State<CardSwitch> createState() => _CardSwitchState();
}

class _CardSwitchState extends State<CardSwitch> {
  @override
  Widget build(BuildContext context) {
    return CardEnvoriments(
      label: widget.label,
      description: widget.description,
      child: PSwicth(
        value: widget.value,
        onChanged: widget.onChanged,
      ),
    );
  }
}
