import 'package:get/get.dart';

mixin Validators {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Digite seu e-mail!';
    } else if (!email.isEmail) {
      return 'Digite um e-mail valido!';
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Digite sua senha!';
    } else if (password.length < 7) {
      return 'Digite uma senha com pelo menos 7 caracteres!';
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Digite um nome!';
    }
    final fullName = name.split(' ');
    if (fullName.length == 1) {
      return 'Digite seu nome completo!';
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Digite um número de celular!';
    }
    if (phone.length < 14 || !phone.isPhoneNumber) {
      return 'Digite um número de celular válido!';
    }
    return null;
  }

  static String? cpfCnpjValidator(String? cpfCnpj) {
    if (cpfCnpj == null || cpfCnpj.isEmpty) {
      return 'Digite um CPF!';
    }
    if (!cpfCnpj.isCpf) {
      return 'Digite um CPF válido!';
    }
    return null;
  }
}
