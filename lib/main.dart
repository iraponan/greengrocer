import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app.dart';
import 'package:greengrocer/src/config/initialize.dart';
import 'package:greengrocer/src/config/setup.dart';

Future<void> main() async {
  await AppInitialize.initializeApp();
  await AppInitialize.initializeEnv();
  await AppInitialize.initializeParseServer();

  AppSetup.setupControllers();

  runApp(const AppGreengrocer());
}
