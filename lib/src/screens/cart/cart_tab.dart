import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/data/items.dart' as items_data;
import 'package:greengrocer/src/helpers/consts.dart';
import 'package:greengrocer/src/models/cart_item.dart';
import 'package:greengrocer/src/screens/cart/components/cart_tile.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items_data.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = items_data.cartItems[index];
                return CartTile(
                  cartItem: items_data.cartItems[index],
                  updateQuantity: (qtd) {
                    if (qtd == 0) {
                      removeItemFromCart(items_data.cartItems[index]);
                    } else {
                      setState(() => cartItem.quantity = qtd);
                    }
                  },
                );
              },
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
                Text(
                  UtilBrasilFields.obterReal(cartTotalPrice(), moeda: true),
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwathColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Consts.heightButton,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();
                      print(result);
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

  void removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      items_data.cartItems.remove(cartItem);
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in items_data.cartItems) {
      total += item.totalPrice();
    }
    return total;
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
