import 'package:greengrocer/src/helpers/enums/payment_status.dart';
import 'package:greengrocer/src/models/cart_item.dart';

class OrderModel {
  OrderModel({
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
  List<CartItemModel> items;
  PaymentStatus status;
  String copyAndPast;
  double total;
}
