import 'package:flutter/material.dart';

mixin ThemeProject {
  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.green,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 2,
          color: Colors.green,
        ),
        foregroundColor: Colors.green,
      ),
    ),
  );
}
