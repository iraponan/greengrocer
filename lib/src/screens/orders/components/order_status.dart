import 'package:flutter/material.dart';
import 'package:greengrocer/src/helpers/enums/payment_status.dart';
import 'package:greengrocer/src/screens/orders/components/custom_divider.dart';
import 'package:greengrocer/src/screens/orders/components/status_dot.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    super.key,
    required this.status,
    required this.isOverdue,
  });

  final PaymentStatus status;
  final bool isOverdue;

  int get currentStatus => status.index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StatusDot(isActive: true, title: 'Pedido Confirmado'),
        const CustomDivider(),
        if (currentStatus == 1) ...[
          const StatusDot(
            isActive: true,
            title: 'Pix Estornado',
            backgroundColor: Colors.orange,
          ),
        ] else if (isOverdue) ...[
          const StatusDot(
            isActive: true,
            title: 'Pagamento Pix Vencido',
            backgroundColor: Colors.red,
          ),
        ] else ...[
          StatusDot(isActive: currentStatus >= 2, title: 'Pagamento'),
          const CustomDivider(),
          StatusDot(isActive: currentStatus >= 3, title: 'Preparando'),
          const CustomDivider(),
          StatusDot(isActive: currentStatus >= 4, title: 'Envio'),
          const CustomDivider(),
          StatusDot(isActive: currentStatus == 5, title: 'Entregue'),
        ],
      ],
    );
  }
}
