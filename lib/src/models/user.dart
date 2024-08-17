import 'package:greengrocer/src/helpers/data_table_keys/columns/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class User {
  User({
    this.id,
    this.token,
    this.name,
    this.email,
    this.phone,
    this.cpfCnpj,
    this.password,
  });

  String? id;
  String? token;
  String? name;
  String? email;
  String? phone;
  String? cpfCnpj;
  String? password;

  factory User.fromMap(ParseUser parseUser) {
    return User(
      id: parseUser.objectId ?? '',
      token: parseUser.sessionToken ?? '',
      name: parseUser.get(UserColumnKeys.name),
      email: parseUser.get(UserColumnKeys.email),
      phone: parseUser.get(UserColumnKeys.phone),
      cpfCnpj: parseUser.get(UserColumnKeys.cpfCnpj),
    );
  }

  @override
  String toString() {
    return 'User{id: $id, token: $token, name: $name, email: $email, phone: $phone, cpfCnpj: $cpfCnpj, password: $password}';
  }
}
