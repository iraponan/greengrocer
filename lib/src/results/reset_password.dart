import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password.freezed.dart';

@freezed
class ResetPasswordResult with _$ResetPasswordResult {
  factory ResetPasswordResult.success(String message) = Success;
  factory ResetPasswordResult.error(String message) = Error;
}
