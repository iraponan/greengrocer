import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/orders.dart';
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
      body: GetBuilder<OrdersController>(builder: (controller) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => OrderTile(
            order: controller.orders[index],
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: controller.orders.length,
        );
      }),
    );
  }
}
