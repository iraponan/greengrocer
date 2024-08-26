import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin VariablesUtils {
  static const Duration pageAnimationDuration = Duration(seconds: 1);
  static final GlobalKey<CartIconKey> globalKeyCartItems =
      GlobalKey<CartIconKey>();
  static const double heightButton = 50;
  static const double heightIconPageEmpty = 75;
  static const IconData tileIconDefault = Icons.add_shopping_cart_outlined;
  static const IconData tileIconCheckDefault = Icons.check;
}

mixin StorageKeys {
  static final String token = dotenv.env['STORAGE_KEY'] ?? '';
}

mixin ConfigPage {
  static const int itemsPerPage = 6;
}

mixin PaymentsConfig {
  static const Duration daysValid = Duration(hours: 1);
}
