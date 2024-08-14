import 'package:greengrocer/src/helpers/data_table_keys/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class User {
  User({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    required this.phone,
    required this.cpfCnpj,
    this.password = '********',
  });

  String id;
  String token;
  String name;
  String email;
  String phone;
  String cpfCnpj;
  String password;

  factory User.fromMap(ParseUser parseUser) {
    return User(
      id: parseUser.objectId ?? '',
      token: parseUser.sessionToken ?? '',
      name: parseUser.get(UserTable.name),
      email: parseUser.get(UserTable.email),
      phone: parseUser.get(UserTable.phone),
      cpfCnpj: parseUser.get(UserTable.cpfCnpj),
    );
  }

  @override
  String toString() {
    return 'User{id: $id, token: $token, name: $name, email: $email, phone: $phone, cpfCnpj: $cpfCnpj, password: $password}';
  }
}
