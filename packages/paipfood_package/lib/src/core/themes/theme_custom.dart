import 'package:flutter/material.dart';
import '../../../paipfood_package.dart';

class ThemeCustom {
  final lightTheme = ThemeData(
    fontFamily: "Roboto",
    useMaterial3: true,
    scaffoldBackgroundColor: paipThemeLight.surface,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: paipThemeLight.primaryColor,
      selectionColor: paipThemeLight.primaryColor.withOpacity(0.5),
      selectionHandleColor: paipThemeLight.primaryColor,
    ),
    appBarTheme: AppBarTheme(backgroundColor: paipThemeLight.primaryBG, surfaceTintColor: paipThemeLight.primaryBG),
    dialogTheme: DialogThemeData(
      backgroundColor: paipThemeLight.primaryBG,
      surfaceTintColor: paipThemeLight.primaryBG,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    brightness: Brightness.light,
    extensions: [paipThemeLight],
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      surface: paipThemeLight.primaryBG, // secondary Backgorund
      onSurface: paipThemeLight.primaryText,
      primary: paipThemeLight.primaryColor,
      onPrimary: paipThemeLight.primaryText,
      secondary: paipThemeLight.primaryColor,
      onSecondary: paipThemeLight.secondaryText,
      error: paipThemeLight.errorColor,
      onError: paipThemeLight.primaryBG,
    ),
  );

  final darkTheme = ThemeData(
    fontFamily: "Roboto",
    useMaterial3: true,
    scaffoldBackgroundColor: paipThemeDark.surface,
    // textTheme: text,
    brightness: Brightness.dark,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: paipThemeLight.primaryColor,
      selectionColor: paipThemeLight.primaryColor.withOpacity(0.5),
      selectionHandleColor: paipThemeLight.primaryColor,
    ),
    appBarTheme: AppBarTheme(backgroundColor: paipThemeDark.primaryBG, surfaceTintColor: paipThemeDark.primaryBG),
    dialogTheme: DialogThemeData(
      backgroundColor: paipThemeDark.primaryBG,
      surfaceTintColor: paipThemeDark.primaryBG,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    extensions: [paipThemeDark],
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      surface: paipThemeDark.primaryBG, // secondary Backgorund
      onSurface: paipThemeDark.primaryText,
      primary: paipThemeDark.primaryColor,
      onPrimary: paipThemeDark.primaryText,
      secondary: paipThemeDark.primaryColor,
      onSecondary: paipThemeDark.secondaryText,
      error: paipThemeDark.errorColor,
      onError: paipThemeDark.primaryText,
    ),
  );

  static const text = TextTheme(
    displayLarge: TextStyle(letterSpacing: 0),
    displayMedium: TextStyle(letterSpacing: 0),
    displaySmall: TextStyle(letterSpacing: 0),
    //
    headlineLarge: TextStyle(letterSpacing: 0),
    headlineMedium: TextStyle(letterSpacing: 0),
    headlineSmall: TextStyle(letterSpacing: 0),
    //
    titleLarge: TextStyle(letterSpacing: 0),
    titleMedium: TextStyle(letterSpacing: 0),
    titleSmall: TextStyle(letterSpacing: 0),
    //
    labelLarge: TextStyle(letterSpacing: 0),
    labelMedium: TextStyle(letterSpacing: 0),
    labelSmall: TextStyle(letterSpacing: 0),
    //
    bodyLarge: TextStyle(letterSpacing: 0),
    bodyMedium: TextStyle(letterSpacing: 0),
    bodySmall: TextStyle(letterSpacing: 0),
  );
}
