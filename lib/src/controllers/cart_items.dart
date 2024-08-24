import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/cart_items.dart';
import 'package:greengrocer/src/models/product.dart';
import 'package:greengrocer/src/repositories/cart_items.dart';
import 'package:greengrocer/src/results/cart_items.dart';

class CartItemsController extends GetxController {
  final cartItemsRepository = CartItemsRepository();
  final authController = Get.find<AuthController>();

  List<CartItems> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  Future<void> getCartItems() async {
    final CartItemsResult<List<CartItems>> result =
        await cartItemsRepository.getCartItems(user: authController.user);

    result.when(
      success: (cartItems) {
        this.cartItems = cartItems;
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

  double cartTotalPrice() {
    double total = 0;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  int getProductItemIndex(Product product) {
    return cartItems
        .indexWhere((productInList) => productInList.product.id == product.id);
  }

  Future<void> addItemToCart({
    required Product product,
    int quantity = 1,
  }) async {
    int productItemIndex = getProductItemIndex(product);

    if (productItemIndex >= 0) {
      final cartItem = cartItems[productItemIndex];
      cartItem.quantity += quantity;
      final result = await changeItemQuantity(cartItem: cartItem);
      if (result) {
        cartItems[productItemIndex].quantity += quantity;
      } else {}
    } else {
      final CartItemsResult<CartItems> result =
          await cartItemsRepository.addProductItemToCart(
        cartItems: CartItems(product: product, quantity: quantity),
        user: authController.user,
      );

      result.when(
        success: (cartItem) {
          cartItems.add(cartItem);
        },
        error: (message) {
          MethodsUtils.showToast(message: message, isError: true);
        },
      );
    }
    update();
  }

  Future<bool> changeItemQuantity({required CartItems cartItem}) async {
    final result =
        await cartItemsRepository.changeItemQuantity(cartItem: cartItem);
    result.when(
      success: (success) {
        return success;
      },
      error: (message) {
        MethodsUtils.showToast(message: message, isError: true);
        return false;
      },
    );
    return false;
  }
}
