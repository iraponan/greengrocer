import 'package:flutter/material.dart';
import 'package:greengrocer/src/data/orders.dart' as orders_data;
import 'package:greengrocer/src/screens/orders/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => OrderTile(
          order: orders_data.orders[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: orders_data.orders.length,
      ),
    );
  }
}
