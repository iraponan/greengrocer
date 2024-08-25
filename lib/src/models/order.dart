import 'package:greengrocer/src/helpers/data_table_keys/columns/orders.dart';
import 'package:greengrocer/src/helpers/enums/payment_status.dart';
import 'package:greengrocer/src/models/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Order {
  String id;
  User user;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  PaymentStatus status;
  String copyAndPastPIX;
  double total;

  Order({
    required this.id,
    required this.user,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.status,
    required this.copyAndPastPIX,
    required this.total,
  });

  Order.fromParse(ParseObject object, this.user)
      : id = object.objectId ?? '',
        createdDateTime =
            object.get<DateTime>(OrdersColumnKeys.createdAt) ?? DateTime.now(),
        overdueDateTime =
            (object.get<DateTime>(OrdersColumnKeys.overdueDateTime) ??
                DateTime.now()),
        status = PaymentStatus.values.elementAt(int.tryParse(
                object.get<int>(OrdersColumnKeys.paymentStatus).toString()) ??
            0),
        copyAndPastPIX =
            object.get<String>(OrdersColumnKeys.copyAndPastPIX) ?? '',
        total = double.tryParse(
                object.get<double>(OrdersColumnKeys.totalOrder).toString()) ??
            0;

  @override
  String toString() {
    return 'Order{id: $id, createdDateTime: $createdDateTime, overdueDateTime: $overdueDateTime, status: $status, copyAndPastPIX: $copyAndPastPIX, total: $total}';
  }
}
