import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin MethodsUtils {
  static const storage = FlutterSecureStorage();

  static Future<void> saveLocalData({
    required String key,
    required String data,
  }) async {
    await storage.write(key: key, value: data);
  }

  static Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  static Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  static void showToast({required String message, bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14.0,
    );
  }
}
