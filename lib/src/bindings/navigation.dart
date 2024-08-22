import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/navigation.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}
