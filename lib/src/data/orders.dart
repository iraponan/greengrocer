import 'package:greengrocer/src/data/items.dart';
import 'package:greengrocer/src/models/cart_item.dart';
import 'package:greengrocer/src/models/order.dart';

List<OrderModel> orders = [
  OrderModel(
    id: 'a1b2c3d4',
    createdDateTime: DateTime(2024, 6, 1, 10, 15, 10, 458),
    overdueDateTime: DateTime(2024, 12, 1, 11, 15, 10, 458),
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
    copyAndPast: 'q1w2e3r4t5y6u7i8o9p0',
    total: 18.5,
  ),
  OrderModel(
    id: 'e5f6g7h8',
    createdDateTime: DateTime(2024, 6, 1, 16, 30, 55, 012),
    overdueDateTime: DateTime(2024, 12, 1, 17, 30, 55, 012),
    items: [
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
    ],
    status: 'delivered',
    copyAndPast: 'p0o9i8u7y6t5r4e3w2q1',
    total: 11.5,
  ),
];
