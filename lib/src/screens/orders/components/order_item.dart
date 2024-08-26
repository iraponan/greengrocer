import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/orders_items.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.orderItem});

  final OrdersItems orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.product.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.product.productName)),
          Text(UtilBrasilFields.obterReal(
              orderItem.quantity * orderItem.product.price,
              moeda: true)),
        ],
      ),
    );
  }
}
