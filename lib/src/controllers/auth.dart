import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/user.dart';
import 'package:greengrocer/src/repositories/auth.dart';
import 'package:greengrocer/src/results/auth.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();

  User user = User();

  Future<void> signIn({required String email, required String password}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading.value = true;
    AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        Get.offAllNamed(PageRoutes.baseRoute);
      },
      error: (message) {
        MethodsUtils.showToast(message: message, isError: true);
      },
    );
  }
}
