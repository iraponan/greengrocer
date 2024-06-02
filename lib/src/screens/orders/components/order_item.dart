import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/cart_item.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.orderItem});

  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(UtilBrasilFields.obterReal(orderItem.totalPrice(), moeda: true)),
        ],
      ),
    );
  }
}
