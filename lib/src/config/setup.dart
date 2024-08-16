import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth.dart';

mixin AppSetup {
  static void setupApp() async {
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
  }

  static void setupControllers() {
    Get.put(AuthController());
  }
}
