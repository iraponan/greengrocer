import 'package:get/get.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/order.dart';
import 'package:greengrocer/src/models/orders_items.dart';
import 'package:greengrocer/src/repositories/orders_items.dart';

class OrdersItemsController extends GetxController {
  Order order;

  OrdersItemsController({
    required this.order,
  });

  final ordersItemsRepository = OrdersItemsRepository();

  List<OrdersItems> ordersItems = [];
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getItemsFromOrder() async {
    setLoading(true);
    final result =
        await ordersItemsRepository.gelAllItemsFromOrder(order: order);
    setLoading(false);

    result.when(
      success: (ordersItems) {
        this.ordersItems = ordersItems;
        update();
      },
      error: (message) {
        MethodsUtils.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
