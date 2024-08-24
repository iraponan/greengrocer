import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

mixin MethodsUtils {
  static void showToast(
      {required String message,
      bool isError = false,
      bool isCartRemove = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError
          ? CustomColors.customContrastColor
          : isCartRemove
              ? Colors.white
              : CustomColors.customSwathColor,
      textColor: isCartRemove ? Colors.black : Colors.white,
      fontSize: 14.0,
    );
  }
}
