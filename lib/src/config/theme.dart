import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

mixin ThemeProject {
  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white.withAlpha(190),
    appBarTheme: AppBarTheme(
      backgroundColor: CustomColors.customSwathColor,
      surfaceTintColor: CustomColors.customSwathColor,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    cardTheme: const CardTheme(
      elevation: 3,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.customSwathColor,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 2,
          color: CustomColors.customSwathColor,
        ),
        foregroundColor: CustomColors.customSwathColor,
      ),
    ),
  );
}
