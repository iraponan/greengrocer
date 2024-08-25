import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/cart_items.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/helpers/utils/variables.dart';
import 'package:greengrocer/src/models/cart_items.dart';
import 'package:greengrocer/src/screens/cart/components/cart_tile.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

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
            child: GetBuilder<CartItemsController>(
              builder: (controller) => controller.cartItems.isNotEmpty
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListView.builder(
                            itemCount: controller.cartItems.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final cartItem = controller.cartItems[index];
                              return CartTile(
                                cartItem: controller.cartItems[index],
                                updateQuantity: (qtd) {
                                  if (qtd == 0) {
                                    cartItem.quantity = 0;
                                    controller.changeItemQuantity(
                                        cartItem: cartItem);
                                    controller.cartItems.remove(cartItem);
                                    MethodsUtils.showToast(
                                      message:
                                          'Produto: ${cartItem.product.productName} removido(a) do carrinho.',
                                      isInfo: true,
                                    );
                                  } else {
                                    cartItem.quantity = qtd;
                                    controller.changeItemQuantity(
                                        cartItem: cartItem);
                                  }
                                  MethodsUtils.updateIconCart(controller);
                                },
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                for (CartItems cartItem
                                    in controller.cartItems) {
                                  controller.changeItemQuantity(
                                      cartItem: cartItem, remove: true);
                                }
                                MethodsUtils.showToast(
                                  message:
                                      'Todos os produtos foram removido(s) do carrinho.',
                                  isInfo: true,
                                );
                                MethodsUtils.updateIconCart(controller);
                              },
                              icon: const Icon(Icons.cleaning_services_rounded),
                              label: const Text('Limpar Carrinho'),
                            ),
                          )
                        ],
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_shopping_cart,
                          size: 40,
                          color: CustomColors.customSwathColor,
                        ),
                        Text(
                          'Não há itens no carrinho!',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.customSwathColor),
                        ),
                      ],
                    ),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Qtd de Itens:',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          GetBuilder<CartItemsController>(
                              builder: (controller) {
                            return Text(
                              controller.getCartQtdTotalItens().toString(),
                              style: TextStyle(
                                fontSize: 23,
                                color: CustomColors.customSwathColor,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: Colors.black,
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            'Total Geral:',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          GetBuilder<CartItemsController>(
                              builder: (controller) {
                            return Text(
                              UtilBrasilFields.obterReal(
                                  controller.cartTotalPrice(),
                                  moeda: true),
                              style: TextStyle(
                                fontSize: 23,
                                color: CustomColors.customSwathColor,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                GetBuilder<CartItemsController>(builder: (controller) {
                  return SizedBox(
                    height: VariablesUtils.heightButton,
                    child: ElevatedButton(
                      onPressed: !controller.isCheckoutLoading &&
                              controller.cartItems.isEmpty
                          ? null
                          : () async {
                              bool? result =
                                  await showOrderConfirmation(context);
                              if (result ?? false) {
                                controller.checkoutCart();
                              } else {
                                MethodsUtils.showToast(
                                    message: 'Pedido não confirmado',
                                    isInfo: true);
                              }
                            },
                      child: controller.isCheckoutLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Concluir Pedido',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                    ),
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation(BuildContext context) => showDialog<bool>(
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
