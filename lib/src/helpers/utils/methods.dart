import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/cart_items.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/models/order.dart';
import 'package:pix_flutter/pix_flutter.dart';

mixin MethodsUtils {
  static void showToast(
      {required String message, bool isError = false, bool isInfo = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError
          ? CustomColors.customContrastColor
          : isInfo
              ? Colors.white
              : CustomColors.customSwathColor,
      textColor: isInfo ? Colors.black : Colors.white,
      fontSize: 14.0,
    );
  }

  static void updateIconCart(CartItemsController cartItemsController) async {
    await VariablesUtils.globalKeyCartItems.currentState?.runCartAnimation(
        (cartItemsController.getCartQtdTotalItens()).toString());
  }

  static String getPIXQRCode(Order order) {
    return PixFlutter(
      payload: Payload(
          pixKey: dotenv.env['PIX_KEY'],
          description: 'Compra Nº: ${order.id}',
          merchantName: dotenv.env['MERCHANT_NAME'],
          merchantCity: dotenv.env['MERCHANT_CITY'],
          txid: '${dotenv.env['APP_NAME']}${order.id}',
          amount: order.total.toString(),
          isUniquePayment: true),
    ).getQRCode();
  }
}
