import 'package:greengrocer/src/helpers/enums/payment_status.dart';
import 'package:greengrocer/src/models/cart_product.dart';

class Order {
  Order({
    required this.id,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.copyAndPast,
    required this.total,
  });

  String id;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  List<CartProduct> items;
  PaymentStatus status;
  String copyAndPast;
  double total;

  @override
  String toString() {
    return 'OrderModel{id: $id, createdDateTime: $createdDateTime, overdueDateTime: $overdueDateTime, items: $items, status: $status, copyAndPast: $copyAndPast, total: $total}';
  }
}
