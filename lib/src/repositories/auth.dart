import 'package:greengrocer/src/helpers/data_table_keys/user.dart';
import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/user.dart';
import 'package:greengrocer/src/results/auth.dart';
import 'package:greengrocer/src/results/reset_password.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthRepository {
  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final parseUser = ParseUser(email, password, email);
    final response = await parseUser.login();
    return handleUserOrError(response);
  }

  Future<AuthResult> currentUser({String? token}) async {
    final response = await ParseUser.getCurrentUserFromServer(token ?? '');
    return handleUserOrError(response);
  }

  Future<AuthResult> signUp({required User user}) async {
    final ParseUser parseUser =
        ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(UserTable.name, user.name ?? '');
    parseUser.set<String>(UserTable.phone, user.phone ?? '');
    parseUser.set<String>(UserTable.cpfCnpj, user.cpfCnpj ?? '');

    final response = await parseUser.save();

    return handleUserOrError(response);
  }

  Future<ResetPasswordResult> resetPassword(String email) async {
    final ParseUser user = ParseUser(null, null, email);
    final ParseResponse response = await user.requestPasswordReset();

    if (response.success) {
      return ResetPasswordResult.success(
          'Solicitação de Recuperação de Senha Enviada!');
    } else {
      return ResetPasswordResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  AuthResult handleUserOrError(ParseResponse? response) {
    if (response != null && response.success) {
      return AuthResult.success(User.fromMap(response.result));
    } else {
      return AuthResult.error(
        ParseErrors.getDescription(response?.error?.code ?? -1),
      );
    }
  }
}
