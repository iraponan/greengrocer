import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app.dart';
import 'package:greengrocer/src/config/setup.dart';

void main() {
  AppSetup.setupControllers();
  runApp(const AppGreengrocer());
}
