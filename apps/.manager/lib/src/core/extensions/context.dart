import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ArtColorScheme artColors() => ArtTheme.of(this).colorScheme;

  ArtTextTheme artTextTheme() => ArtTheme.of(this).textTheme;
}
