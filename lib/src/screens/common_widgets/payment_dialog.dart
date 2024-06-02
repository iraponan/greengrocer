import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/order.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  const PaymentDialog({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Pagamento com PIX',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                QrImageView(
                  data: '1234567890',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                Text(
                  'Vencimento: ${UtilData.obterDataDDMMAAAA(order.overdueDateTime)}'
                  ' ${UtilData.obterHoraHHMMSS(order.overdueDateTime)}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Total: ${UtilBrasilFields.obterReal(order.total, moeda: true)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.copy,
                    size: 15,
                  ),
                  label: const Text(
                    'Copiar Código PIX',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
