import 'package:greengrocer/src/models/product.dart';

class CartProduct {
  CartProduct({
    this.id,
    required this.product,
    required this.quantity,
  });

  String? id;
  Product product;
  int quantity;

  double totalPrice() => product.price * quantity;

  @override
  String toString() {
    return 'CartProductModel{product: $product, quantity: $quantity}';
  }
}
