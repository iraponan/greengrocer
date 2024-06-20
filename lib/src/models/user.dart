class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.cpf,
    this.password,
  });

  String id;
  String name;
  String email;
  String phone;
  String cpf;
  String? password;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, cpf: $cpf, password: $password}';
  }
}
