import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/home.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
