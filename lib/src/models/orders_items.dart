import 'package:greengrocer/src/helpers/data_table_keys/columns/orders_items.dart';
import 'package:greengrocer/src/models/order.dart';
import 'package:greengrocer/src/models/product.dart';
import 'package:greengrocer/src/models/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class OrdersItems {
  String id;
  Order order;
  Product product;
  int quantity;
  double price;

  OrdersItems({
    required this.id,
    required this.order,
    required this.product,
    required this.quantity,
    required this.price,
  });

  OrdersItems.fromParse(ParseObject object, User user)
      : id = object.objectId ?? '',
        order = Order.fromParse(object.get(OrdersItemsColumnKeys.order), user),
        product = Product.fromParse(object.get(OrdersItemsColumnKeys.product)),
        quantity = int.tryParse(
                object.get<num>(OrdersItemsColumnKeys.quantity).toString()) ??
            0,
        price = double.tryParse(
                object.get<num>(OrdersItemsColumnKeys.price).toString()) ??
            0;

  OrdersItems.fromParseFromCart(ParseObject object, User user, this.product)
      : id = object.objectId ?? '',
        order = Order.fromParse(object.get(OrdersItemsColumnKeys.order), user),
        quantity = int.tryParse(
                object.get<num>(OrdersItemsColumnKeys.quantity).toString()) ??
            0,
        price = double.tryParse(
                object.get<num>(OrdersItemsColumnKeys.price).toString()) ??
            0;

  @override
  String toString() {
    return 'OrdersItems{id: $id, order: $order, product: $product, quantity: $quantity, price: $price}';
  }
}
