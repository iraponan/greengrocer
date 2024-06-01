import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item.dart';
import 'package:greengrocer/src/screens/common_widgets/quantity_widget.dart';

class CartTile extends StatefulWidget {
  const CartTile({
    super.key,
    required this.cartItem,
    required this.remove,
  });

  final CartItemModel cartItem;
  final Function(CartItemModel) remove;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListTile(
        // # Imagem #
        leading: Image.asset(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        // # Título #
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        // # Total #
        subtitle: Text(
          UtilBrasilFields.obterReal(
            widget.cartItem.totalPrice(),
            moeda: true,
          ),
          style: TextStyle(
            color: CustomColors.customSwathColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // # Quantidade #
        trailing: QuantityWidget(
          quantity: widget.cartItem.quantity,
          suffixText: widget.cartItem.item.unit,
          isRemovable: true,
          result: (quantity) => setState(() {
            widget.cartItem.quantity = quantity;
            if (quantity == 0) {
              widget.remove(widget.cartItem);
            }
          }),
        ),
      ),
    );
  }
}
