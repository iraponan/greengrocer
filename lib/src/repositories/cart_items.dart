import 'package:greengrocer/src/helpers/data_table_keys/columns/cart_items.dart';
import 'package:greengrocer/src/helpers/data_table_keys/columns/user.dart';
import 'package:greengrocer/src/helpers/data_table_keys/tables.dart';
import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/cart_items.dart';
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
}
