import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/cart_items.dart';
import 'package:greengrocer/src/helpers/utils/variables.dart';

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

  static void updateIconCart(CartItemsController cartItemsController) async {
    await VariablesUtils.globalKeyCartItems.currentState?.runCartAnimation(
        (cartItemsController.getCartQtdTotalItens()).toString());
  }
}
