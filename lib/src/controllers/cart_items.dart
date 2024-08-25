import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth.dart';
import 'package:greengrocer/src/helpers/enums/payment_status.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/cart_items.dart';
import 'package:greengrocer/src/models/order.dart';
import 'package:greengrocer/src/models/orders_items.dart';
import 'package:greengrocer/src/models/product.dart';
import 'package:greengrocer/src/repositories/cart_items.dart';
import 'package:greengrocer/src/repositories/orders.dart';
import 'package:greengrocer/src/repositories/orders_items.dart';
import 'package:greengrocer/src/results/cart_items.dart';
import 'package:greengrocer/src/results/orders.dart';
import 'package:greengrocer/src/screens/common_widgets/payment_dialog.dart';

class CartItemsController extends GetxController {
  final cartItemsRepository = CartItemsRepository();
  final orderRepository = OrdersRepository();
  final ordersItemsRepository = OrdersItemsRepository();
  final authController = Get.find<AuthController>();

  List<CartItems> cartItems = [];

  bool isCheckoutLoading = false;

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
      cartItems[productItemIndex].quantity += quantity;
      final cartItem = cartItems[productItemIndex];
      await changeItemQuantity(cartItem: cartItem);
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

  Future<bool> changeItemQuantity(
      {required CartItems cartItem,
      bool remove = false,
      bool clearList = true}) async {
    if (remove) {
      cartItem.quantity = 0;
    }

    final result =
        await cartItemsRepository.changeItemQuantity(cartItem: cartItem);
    result.when(
      success: (success) {
        if (cartItem.quantity == 0 && clearList) {
          cartItems.removeWhere((c) => c.id == cartItem.id);
        }
        update();
        return success;
      },
      error: (message) {
        MethodsUtils.showToast(message: message, isError: true);
        update();
        return false;
      },
    );
    update();
    return false;
  }

  int getCartQtdTotalItens() {
    return cartItems.isEmpty
        ? 0
        : cartItems.map((c) => c.quantity).reduce((a, b) => a + b);
  }

  Future<void> checkoutCart() async {
    setCheckoutLoading(true);
    Order order = Order(
      id: '',
      user: authController.user,
      createdDateTime: DateTime.now(),
      overdueDateTime: DateTime.now().add(PaymentsConfig.daysValid),
      status: PaymentStatus.pendingPayment,
      copyAndPastPIX: 'copyAndPastPIX',
      total: cartTotalPrice(),
    );
    OrdersResult<Order> resultOrder =
        await orderRepository.addNewOrder(order: order);
    List<OrdersItems> resultOrdersItems = [];

    resultOrder.when(
      success: (order) async {
        order.copyAndPastPIX = MethodsUtils.getPIXQRCode(order);
        orderRepository.updatePIXQRCode(order);
        for (CartItems cartItem in cartItems) {
          final result = await ordersItemsRepository.addNewOrdersItems(
              order: order, cartItems: cartItem);
          result.when(
            success: (orderItem) async {
              resultOrdersItems.add(orderItem);
              await changeItemQuantity(
                  cartItem: cartItem, remove: true, clearList: false);
            },
            error: (message) {
              MethodsUtils.showToast(
                message: message,
              );
            },
          );
        }
        cartItems.clear();
        setCheckoutLoading(false);
        showDialog(
          context: Get.context!,
          builder: (_) => PaymentDialog(
            order: order,
          ),
        );
      },
      error: (message) {
        MethodsUtils.showToast(
          message: message,
        );
      },
    );
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }
}
