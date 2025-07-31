// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CwSwitchLightDark extends StatelessWidget {
  final bool isDarkMode;
  final void Function(bool value) onChanged;

  const CwSwitchLightDark({
    required this.isDarkMode,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      thumbIcon: WidgetStatePropertyAll(
        isDarkMode ? const Icon(PIcons.strokeRoundedMoon02, color: Colors.black) : const Icon(PIcons.strokeRoundedSun02, color: Colors.black),
      ),
      activeTrackColor: PColors.dark.onPrimaryBG,
      // activeColor: Colors.white,
      inactiveTrackColor: PColors.light.onPrimaryBG,
      // trackColor: const MaterialStatePropertyAll(Colors.blue),
      thumbColor: WidgetStatePropertyAll(isDarkMode ? Colors.white : Colors.amber),
      hoverColor: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.blueAccent.withOpacity(0.3),
      value: isDarkMode,
      onChanged: onChanged,
    );
  }
}
