import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth.dart';

mixin AppSetup {
  static void setupControllers() {
    Get.put(AuthController());
  }
}
