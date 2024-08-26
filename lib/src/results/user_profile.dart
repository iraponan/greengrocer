import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfileResult with _$UserProfileResult {
  factory UserProfileResult.success(bool value) = Success;
  factory UserProfileResult.error(String message) = Error;
}
