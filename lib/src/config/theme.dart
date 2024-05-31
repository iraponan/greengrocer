import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

mixin ThemeProject {
  static final theme = ThemeData(
    scaffoldBackgroundColor: CustomColors.customSwathColor,
    appBarTheme: AppBarTheme(
      backgroundColor: CustomColors.customSwathColor.shade900,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.customSwathColor.shade900,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 2,
          color: CustomColors.customSwathColor.shade900,
        ),
        foregroundColor: CustomColors.customSwathColor.shade900,
      ),
    ),
  );
}
