import 'package:greengrocer/src/helpers/data_table_keys/columns/orders.dart';
import 'package:greengrocer/src/helpers/data_table_keys/columns/user.dart';
import 'package:greengrocer/src/helpers/data_table_keys/tables.dart';
import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/order.dart';
import 'package:greengrocer/src/models/user.dart';
import 'package:greengrocer/src/results/orders.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class OrdersRepository {
  Future<OrdersResult<List<Order>>> getAllOrders({required User user}) async {
    final queryBuilder =
        QueryBuilder(ParseObject(TablesNameKeys.keyOrdersTable))
          ..includeObject([OrdersColumnKeys.user])
          ..whereEqualTo(
              OrdersColumnKeys.user,
              (ParseObject(TablesNameKeys.keyUserTable)
                    ..set(UserColumnKeys.id, user.id))
                  .toPointer())
          ..orderByDescending(OrdersColumnKeys.createdAt);

    final response = await queryBuilder.query();

    if (response.success) {
      List<Order> orders =
          response.results?.map((o) => Order.fromParse(o, user)).toList() ?? [];
      return OrdersResult<List<Order>>.success(orders);
    } else {
      return OrdersResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<OrdersResult<Order>> addNewOrder({
    required Order order,
  }) async {
    final parseUser = await ParseUser.currentUser();

    final parseAcl = ParseACL(owner: parseUser)
      ..setPublicReadAccess(allowed: false)
      ..setPublicWriteAccess(allowed: false);

    final orderObject = ParseObject(TablesNameKeys.keyOrdersTable)
      ..setACL(parseAcl)
      ..set<ParseUser>(OrdersColumnKeys.user, parseUser)
      ..set<DateTime>(OrdersColumnKeys.overdueDateTime, order.overdueDateTime)
      ..set<int>(OrdersColumnKeys.paymentStatus, order.status.index)
      ..set<String>(OrdersColumnKeys.copyAndPastPIX, order.copyAndPastPIX)
      ..set<double>(OrdersColumnKeys.totalOrder, order.total);

    final response = await orderObject.save();

    if (response.success) {
      return OrdersResult<Order>.success(
          Order.fromParse(response.result, order.user));
    } else {
      return OrdersResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<Order> updatePIXQRCode(Order order) async {
    final orderObject = ParseObject(TablesNameKeys.keyOrdersTable)
      ..set<String>(OrdersColumnKeys.id, order.id)
      ..set(OrdersColumnKeys.copyAndPastPIX, order.copyAndPastPIX);

    final response = await orderObject.save();

    if (response.success) {
      return response.result;
    } else {
      return Future.error(
          ParseErrors.getDescription(response.error?.code ?? -1));
    }
  }
}
