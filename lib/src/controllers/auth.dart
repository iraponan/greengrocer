import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/repositories/auth.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();

  Future<void> signIn({required String email, required String password}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading.value = true;
    try {
      final user =
          await authRepository.signIn(email: email, password: password);
      print('Usuário: ${user.toString()}');
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }
}
