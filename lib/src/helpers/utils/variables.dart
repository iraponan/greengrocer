import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';

mixin VariablesUtils {
  static final PageController pageController = PageController();
  static const Duration pageAnimationDuration = Duration(seconds: 1);
  static final GlobalKey<CartIconKey> globalKeyCartItems =
      GlobalKey<CartIconKey>();
  static int selectedPage = 0;
  static int cartQuantityItems = 0;
  static const double heightButton = 50;
}
