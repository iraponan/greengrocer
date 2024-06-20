import 'package:greengrocer/src/helpers/data_table_keys/user.dart';
import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthRepository {
  Future<User> signIn({required String email, required String password}) async {
    final parseUser = ParseUser(email, password, email);
    final response = await parseUser.login();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(
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
        return mapParseToUser(response.result);
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }

  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId ?? '',
      name: parseUser.get(UserTable.name),
      email: parseUser.get(UserTable.email),
      phone: parseUser.get(UserTable.phone),
      cpf: parseUser.get(UserTable.cpfCnpj),
    );
  }
}
