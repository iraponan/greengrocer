import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';

mixin VariablesUtils {
  static const Duration pageAnimationDuration = Duration(seconds: 1);
  static final GlobalKey<CartIconKey> globalKeyCartItems =
      GlobalKey<CartIconKey>();
  static int cartQuantityItems = 0;
  static const double heightButton = 50;
  static IconData tileIconDefault = Icons.add_shopping_cart_outlined;
  static IconData tileIconCheckDefault = Icons.check;
}
