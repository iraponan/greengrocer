import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/orders_items.dart';
import 'package:greengrocer/src/helpers/enums/payment_status.dart';
import 'package:greengrocer/src/models/order.dart';
import 'package:greengrocer/src/screens/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/screens/orders/components/order_item.dart';
import 'package:greengrocer/src/screens/orders/components/order_status.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrdersItemsController>(
            init: OrdersItemsController(order: order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                initiallyExpanded: false,
                onExpansionChanged: (value) {
                  if (value && controller.ordersItems.isEmpty) {
                    controller.getItemsFromOrder();
                  }
                },
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pedido: ${order.id}'),
                    Text(
                      '${UtilData.obterDataDDMMAAAA(order.createdDateTime.toLocal())}'
                      ' ${UtilData.obterHoraHHMMSS(order.createdDateTime.toLocal())}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                      children: controller.ordersItems
                                          .map((orderItem) =>
                                              OrderItem(orderItem: orderItem))
                                          .toList()),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                                width: 8,
                              ),
                              Expanded(
                                flex: 2,
                                child: OrderStatus(
                                  status: order.status,
                                  isOverdue: order.isOverDue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Total ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                  text: UtilBrasilFields.obterReal(order.total,
                                      moeda: true)),
                            ],
                          ),
                        ),
                        Visibility(
                          visible:
                              order.status == PaymentStatus.pendingPayment &&
                                  !order.isOverDue,
                          child: ElevatedButton.icon(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (c) => PaymentDialog(
                                order: order,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(),
                            icon: const Icon(Icons.pix),
                            label: const Text('Ver QR Code PIX'),
                          ),
                        ),
                      ],
              );
            }),
      ),
    );
  }
}
