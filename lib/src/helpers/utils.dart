import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';

mixin Utils {
  static GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();
  static const double heightButton = 50;
  static const Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };
}
