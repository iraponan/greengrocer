import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item.dart';
import 'package:greengrocer/src/screens/common_widgets/quantity_widget.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListTile(
        // # Imagem #
        leading: Image.asset(
          cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        // # Título #
        title: Text(
          cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        // # Total #
        subtitle: Text(
          UtilBrasilFields.obterReal(
            cartItem.totalPrice(),
            moeda: true,
          ),
          style: TextStyle(
            color: CustomColors.customSwathColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // # Quantidade #
        trailing: QuantityWidget(
          quantity: cartItem.quantity,
          suffixText: cartItem.item.unit,
          result: (quantity) {},
        ),
      ),
    );
  }
}
