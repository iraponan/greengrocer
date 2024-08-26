import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/order.dart';
import 'package:greengrocer/src/repositories/orders.dart';
import 'package:greengrocer/src/results/orders.dart';

class OrdersController extends GetxController {
  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();

  List<Order> orders = [];

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<Order>> result =
        await ordersRepository.getAllOrders(user: authController.user);

    result.when(
      success: (orders) {
        this.orders = orders;
        update();
      },
      error: (message) {
        MethodsUtils.showToast(message: message, isError: true);
      },
    );
  }
}
