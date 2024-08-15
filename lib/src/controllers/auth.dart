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

  Future<void> getCurrentUser() async {
    String? token = await MethodsUtils.getLocalData(key: StorageKeys.token);
    if (token == null || token.isEmpty) {
      Get.offAllNamed(PageRoutes.signInRoute);
      return;
    } else {
      AuthResult result = await authRepository.currentUser(token: token);
      result.when(
        success: (user) {
          this.user = user;
          saveTokenAndProceedToBase();
        },
        error: (message) {
          signOut();
        },
      );
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading.value = true;
    AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        MethodsUtils.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> signOut() async {
    user = User();
    MethodsUtils.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PageRoutes.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    MethodsUtils.saveLocalData(key: StorageKeys.token, data: user.token!);
    Get.offAllNamed(PageRoutes.baseRoute);
  }
}
