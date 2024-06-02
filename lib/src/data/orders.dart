import 'package:greengrocer/src/data/items.dart';
import 'package:greengrocer/src/models/cart_item.dart';
import 'package:greengrocer/src/models/order.dart';

List<OrderModel> orders = [
  OrderModel(
    id: 'q1w2e3r4t5y6u7i8o9p0',
    createdDateTime: DateTime.parse('2024-06-01 10:00:10:458'),
    overdueDateTime: DateTime.parse('2024-06-02 10:00:10:458'),
    items: [
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
    ],
    status: 'pending_payment',
    copyAndPast: 'a5qdf564sdf87',
    total: 11.0,
  )
];
