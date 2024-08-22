import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/cart_items.dart';

class CartItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartItemsController());
  }
}
