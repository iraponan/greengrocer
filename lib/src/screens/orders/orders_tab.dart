import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/orders.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
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
      body: GetBuilder<OrdersController>(
        builder: (controller) {
          return controller.orders.isEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.clear_all,
                      size: VariablesUtils.heightIconPageEmpty,
                      color: CustomColors.customSwathColor,
                    ),
                    Text(
                      'Não há pedidos realizados ainda!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwathColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : RefreshIndicator(
                  onRefresh: () => controller.getAllOrders(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) => OrderTile(
                      order: controller.orders[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: controller.orders.length,
                  ),
                );
        },
      ),
    );
  }
}
