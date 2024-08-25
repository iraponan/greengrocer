import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_items.freezed.dart';

@freezed
class OrdersItemsResult<T> with _$OrdersItemsResult<T> {
  factory OrdersItemsResult.success(T data) = Success;
  factory OrdersItemsResult.error(String message) = Error;
}
