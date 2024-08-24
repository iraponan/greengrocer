import 'package:greengrocer/src/helpers/data_table_keys/columns/cart_items.dart';
import 'package:greengrocer/src/models/product.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CartItems {
  String id;
  Product product;
  int quantity;

  CartItems({
    this.id = '',
    required this.product,
    required this.quantity,
  });

  CartItems.fromParse(ParseObject object)
      : id = object.objectId ?? '',
        product = Product.fromParse(object.get(CartItemsColumnKeys.product)),
        quantity = int.tryParse(
                object.get<num>(CartItemsColumnKeys.quantity).toString()) ??
            0;

  CartItems.fromParseToAddCart(ParseObject object, this.product)
      : id = object.objectId ?? '',
        quantity = int.tryParse(
                object.get<num>(CartItemsColumnKeys.quantity).toString()) ??
            0;

  double totalPrice() => product.price * quantity;

  @override
  String toString() {
    return 'CartProduct{id: $id, product: $product, quantity: $quantity}';
  }
}
