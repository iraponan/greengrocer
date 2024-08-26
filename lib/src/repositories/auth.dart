import 'package:greengrocer/src/helpers/data_table_keys/columns/user.dart';
import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/user.dart';
import 'package:greengrocer/src/results/auth.dart';
import 'package:greengrocer/src/results/reset_password.dart';
import 'package:greengrocer/src/results/user_profile.dart';
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

    parseUser.set<String>(UserColumnKeys.name, user.name ?? '');
    parseUser.set<String>(UserColumnKeys.phone, user.phone ?? '');
    parseUser.set<String>(UserColumnKeys.cpfCnpj, user.cpfCnpj ?? '');

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

  Future<UserProfileResult> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final parseUser = ParseUser(email, currentPassword, email);
    final responseLogin = await parseUser.login();

    if (responseLogin.success) {
      final user = User.fromParseUser(responseLogin.result);

      if (user.email != email) {
        return UserProfileResult.error(
            'Usuário para alteração de senha inválido!');
      } else {
        parseUser.set(UserColumnKeys.password, newPassword);

        final response = await parseUser.save();

        if (response.success) {
          return UserProfileResult.success(true);
        } else {
          return UserProfileResult.error(
              ParseErrors.getDescription(response.error?.code ?? -1));
        }
      }
    } else {
      return UserProfileResult.error(
          ParseErrors.getDescription(responseLogin.error?.code ?? -1));
    }
  }

  AuthResult handleUserOrError(ParseResponse? response) {
    if (response != null && response.success) {
      return AuthResult.success(User.fromParseUser(response.result));
    } else {
      return AuthResult.error(
        ParseErrors.getDescription(response?.error?.code ?? -1),
      );
    }
  }
}
