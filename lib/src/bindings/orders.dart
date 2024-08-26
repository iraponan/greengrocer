import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/orders.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrdersController());
  }
}
