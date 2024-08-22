import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/cart_items.dart';
import 'package:greengrocer/src/repositories/cart_items.dart';
import 'package:greengrocer/src/results/cart_items.dart';

class CartItemsController extends GetxController {
  final cartItemsRepository = CartItemsRepository();
  final authController = Get.find<AuthController>();

  List<CartItems> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    print('Teste');
    getCartItems();
  }

  Future<void> getCartItems() async {
    final CartItemsResult<List<CartItems>> result =
        await cartItemsRepository.getCartItems(user: authController.user);

    result.when(
      success: (cartItems) {
        this.cartItems = cartItems;
        update();
        print('CarItems valor: ${this.cartItems}');
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
