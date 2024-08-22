import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_items.freezed.dart';

@freezed
class CartItemsResult<T> with _$CartItemsResult<T> {
  factory CartItemsResult.success(T data) = Success;
  factory CartItemsResult.error(String message) = Error;
}
