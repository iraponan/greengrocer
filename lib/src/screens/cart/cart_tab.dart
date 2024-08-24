import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/cart_items.dart';
import 'package:greengrocer/src/controllers/navigation.dart';
import 'package:greengrocer/src/data/orders.dart' as orders_data;
import 'package:greengrocer/src/helpers/enums/navigation_tabs.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/helpers/utils/variables.dart';
import 'package:greengrocer/src/models/cart_items.dart';
import 'package:greengrocer/src/screens/cart/components/cart_tile.dart';
import 'package:greengrocer/src/screens/common_widgets/payment_dialog.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final navigationController = Get.find<NavigationController>();
  final cartItemsController = Get.find<CartItemsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                GetBuilder<CartItemsController>(builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.cartItems.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final cartItem = controller.cartItems[index];
                      return CartTile(
                        cartItem: controller.cartItems[index],
                        updateQuantity: (qtd) {
                          if (qtd == 0) {
                            removeItemFromCart(controller.cartItems[index]);
                          } else {
                            setState(() => cartItem.quantity = qtd);
                          }
                        },
                      );
                    },
                  );
                }),
                cartItemsController.cartItems.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton.icon(
                          onPressed: () => setState(() {
                            VariablesUtils.cartQuantityItems = 0;
                            VariablesUtils.globalKeyCartItems.currentState
                                ?.runClearCartAnimation();
                            cartItemsController.cartItems.clear();
                            navigationController.navigatePageView(
                                page: NavigationTabs.home.index);
                          }),
                          icon: const Icon(Icons.cleaning_services_rounded),
                          label: const Text('Limpar Carrinho'),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total Geral:',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                GetBuilder<CartItemsController>(builder: (controller) {
                  return Text(
                    UtilBrasilFields.obterReal(controller.cartTotalPrice(),
                        moeda: true),
                    style: TextStyle(
                      fontSize: 23,
                      color: CustomColors.customSwathColor,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                SizedBox(
                  height: VariablesUtils.heightButton,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();
                      if (result ?? false) {
                        showDialog(
                          context: context,
                          builder: (c) => PaymentDialog(
                            order: orders_data.orders.first,
                          ),
                        );
                      } else {
                        MethodsUtils.showToast(
                          message: 'Pedido Não Confirmado',
                          isError: true,
                        );
                      }
                    },
                    child: const Text(
                      'Concluir Pedido',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void removeItemFromCart(CartItems cartItem) {
    setState(() {
      cartItemsController.cartItems.remove(cartItem);
      MethodsUtils.showToast(
        message:
            'Produto: ${cartItem.product.productName} removido(a) do carrinho.',
        isCartRemove: true,
      );
    });
  }

  Future<bool?> showOrderConfirmation() => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Não',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Sim'),
            ),
          ],
        ),
      );
}
