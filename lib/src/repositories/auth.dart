import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/user.dart';
import 'package:greengrocer/src/results/auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthRepository {
  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final parseUser = ParseUser(email, password, email);
    final response = await parseUser.login();

    if (response.success) {
      User user = User.fromMap(response.result);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<User?> currentUser() async {
    final parseUser = await ParseUser.currentUser();

    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);

      if (response != null && response.success) {
        return User.fromMap(response.result);
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }
}
