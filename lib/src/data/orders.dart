import 'package:greengrocer/src/data/items.dart';
import 'package:greengrocer/src/models/cart_item.dart';
import 'package:greengrocer/src/models/order.dart';

List<OrderModel> orders = [
  OrderModel(
    id: 'q1w2e3r4t5y6u7i8o9p0',
    createdDateTime: DateTime(2024, 6, 1, 10, 15, 10, 458),
    overdueDateTime: DateTime(2024, 6, 1, 11, 15, 10, 458),
    items: [
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: mango,
        quantity: 3,
      ),
    ],
    status: 'pending_payment',
    copyAndPast: 'a5qdf564sdf87',
    total: 11.0,
  )
];
