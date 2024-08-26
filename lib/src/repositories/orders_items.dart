import 'package:greengrocer/src/helpers/data_table_keys/columns/orders.dart';
import 'package:greengrocer/src/helpers/data_table_keys/columns/orders_items.dart';
import 'package:greengrocer/src/helpers/data_table_keys/columns/products.dart';
import 'package:greengrocer/src/helpers/data_table_keys/tables.dart';
import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/cart_items.dart';
import 'package:greengrocer/src/models/order.dart';
import 'package:greengrocer/src/models/orders_items.dart';
import 'package:greengrocer/src/results/orders_items.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class OrdersItemsRepository {
  Future<OrdersItemsResult<List<OrdersItems>>> gelAllItemsFromOrder(
      {required Order order}) async {
    final queryBuilder =
        QueryBuilder(ParseObject(TablesNameKeys.keyOrdersItemsTable))
          ..includeObject([
            OrdersItemsColumnKeys.order,
            OrdersItemsColumnKeys.product,
          ])
          ..whereEqualTo(
              OrdersItemsColumnKeys.order,
              (ParseObject(TablesNameKeys.keyOrdersTable)
                    ..set(OrdersColumnKeys.id, order.id))
                  .toPointer())
          ..orderByDescending(OrdersItemsColumnKeys.createdAt);

    final response = await queryBuilder.query();

    if (response.success) {
      List<OrdersItems> ordersItems = response.results
              ?.map((o) => OrdersItems.fromParse(o, order.user))
              .toList() ??
          [];
      return OrdersItemsResult<List<OrdersItems>>.success(ordersItems);
    } else {
      return OrdersItemsResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<OrdersItemsResult<OrdersItems>> addNewOrdersItems({
    required Order order,
    required CartItems cartItems,
  }) async {
    final parseUser = await ParseUser.currentUser();

    final parseAcl = ParseACL(owner: parseUser)
      ..setPublicReadAccess(allowed: false)
      ..setPublicWriteAccess(allowed: false);

    final ordersItemsObject = ParseObject(TablesNameKeys.keyOrdersItemsTable)
      ..setACL(parseAcl)
      ..set<ParseObject>(
          OrdersItemsColumnKeys.order,
          ParseObject(TablesNameKeys.keyOrdersTable)
            ..set(
              OrdersColumnKeys.id,
              order.id,
            ))
      ..set<ParseObject>(
        OrdersItemsColumnKeys.product,
        ParseObject(TablesNameKeys.keyProductsTable)
          ..set(
            ProductsColumnKeys.id,
            cartItems.product.id,
          ),
      )
      ..set<int>(OrdersItemsColumnKeys.quantity, cartItems.quantity)
      ..set<double>(OrdersItemsColumnKeys.price, cartItems.product.price);

    final response = await ordersItemsObject.save();

    if (response.success) {
      return OrdersItemsResult.success(OrdersItems.fromParseFromCart(
          response.result, order.user, cartItems.product));
    } else {
      return OrdersItemsResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }
}
