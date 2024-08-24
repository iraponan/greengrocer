import 'package:greengrocer/src/helpers/data_table_keys/columns/cart_items.dart';
import 'package:greengrocer/src/helpers/data_table_keys/columns/products.dart';
import 'package:greengrocer/src/helpers/data_table_keys/columns/user.dart';
import 'package:greengrocer/src/helpers/data_table_keys/tables.dart';
import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/cart_items.dart';
import 'package:greengrocer/src/models/product.dart';
import 'package:greengrocer/src/models/user.dart';
import 'package:greengrocer/src/results/cart_items.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CartItemsRepository {
  Future<CartItemsResult<List<CartItems>>> getCartItems(
      {required User user}) async {
    final queryBuilder =
        QueryBuilder(ParseObject(TablesNameKeys.keyCartItemsTable))
          ..includeObject([CartItemsColumnKeys.product])
          ..whereEqualTo(
              CartItemsColumnKeys.user,
              (ParseObject(TablesNameKeys.keyUserTable)
                    ..set(UserColumnKeys.id, user.id))
                  .toPointer())
          ..orderByAscending(CartItemsColumnKeys.createdAt);

    final response = await queryBuilder.query();

    if (response.success) {
      List<CartItems> cartItems =
          response.results?.map((c) => CartItems.fromParse(c)).toList() ?? [];
      return CartItemsResult<List<CartItems>>.success(cartItems);
    } else {
      return CartItemsResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<CartItemsResult<CartItems>> addProductItemToCart(
      {required CartItems cartItems, required User user}) async {
    final parseUser = await ParseUser.currentUser();

    final parseAcl = ParseACL(owner: parseUser)
      ..setPublicReadAccess(allowed: false)
      ..setPublicWriteAccess(allowed: false);

    final productItemObject = ParseObject(TablesNameKeys.keyCartItemsTable)
      ..setACL(parseAcl)
      ..set<ParseUser>(CartItemsColumnKeys.user, parseUser)
      ..set<ParseObject>(
        CartItemsColumnKeys.product,
        ParseObject(TablesNameKeys.keyProductsTable)
          ..set(
            ProductsColumnKeys.id,
            cartItems.product.id,
          ),
      )
      ..set<num>(CartItemsColumnKeys.quantity, cartItems.quantity);

    final response = await productItemObject.save();

    if (response.success) {
      Product product = await _getProductToAddToCart(
          productId: response.result
              .get(CartItemsColumnKeys.product)
              .get<String>(ProductsColumnKeys.id));
      return CartItemsResult.success(
          CartItems.fromParseToAddCart(response.result, product));
    } else {
      return CartItemsResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<CartItemsResult<bool>> changeItemQuantity(
      {required CartItems cartItem}) async {
    ParseObject object = ParseObject(TablesNameKeys.keyCartItemsTable)
      ..set(CartItemsColumnKeys.id, cartItem.id);

    ParseResponse response;

    if (cartItem.quantity == 0) {
      response = await object.delete();
    } else {
      object.set(CartItemsColumnKeys.quantity, cartItem.quantity);
      response = await object.save();
    }

    if (response.success) {
      return CartItemsResult.success(true);
    } else {
      return CartItemsResult.error(
          ParseErrors.getDescription(response.error?.code ?? -1));
    }
  }

  Future<Product> _getProductToAddToCart({required String productId}) async {
    final queryBuilder =
        QueryBuilder(ParseObject(TablesNameKeys.keyProductsTable))
          ..includeObject([ProductsColumnKeys.category])
          ..whereEqualTo(ProductsColumnKeys.id, productId);
    final response = await queryBuilder.query();
    if (response.success) {
      return Product.fromParse(response.results?.elementAt(0));
    } else {
      return Future.error(
          ParseErrors.getDescription(response.error?.code ?? -1));
    }
  }
}
