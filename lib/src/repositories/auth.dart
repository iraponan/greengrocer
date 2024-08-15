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
      return AuthResult.success(User.fromMap(response.result));
    } else {
      return AuthResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<AuthResult> currentUser({String? token}) async {
    final response = await ParseUser.getCurrentUserFromServer(token ?? '');

    if (response != null && response.success) {
      return AuthResult.success(User.fromMap(response.result));
    } else {
      return AuthResult.error('Não foi possível pegar o usuário atual.\n'
          'Por favor faça novo login.');
    }
  }
}
