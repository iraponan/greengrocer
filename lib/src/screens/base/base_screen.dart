import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/cart_items.dart';
import 'package:greengrocer/src/controllers/navigation.dart';
import 'package:greengrocer/src/helpers/enums/navigation_tabs.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/screens/base/components/custom_bottom_bar_item.dart';
import 'package:greengrocer/src/screens/cart/cart_tab.dart';
import 'package:greengrocer/src/screens/home/home_tab.dart';
import 'package:greengrocer/src/screens/orders/orders_tab.dart';
import 'package:greengrocer/src/screens/profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();
  final cartItemsController = Get.find<CartItemsController>();

  @override
  Widget build(BuildContext context) {
    Color colorSelected = Colors.white;
    Color colorUnselected = Colors.white.withAlpha(100);

    return Scaffold(
      body: PageView(
        controller: navigationController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) => setState(() {
          MethodsUtils.updateIconCart(cartItemsController);
        }),
        children: const [
          HomeTab(),
          CartTab(),
          OrdersTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomBarDoubleBullet(
          backgroundColor: CustomColors.customSwathColor,
          circle1Color: Colors.red,
          circle2Color: Colors.blue,
          color: Colors.white,
          selectedIndex: navigationController.currentIndex,
          items: [
            BottomBarItem(
              iconBuilder: (color) => CustomBottomBarItem(
                colorSelected: colorSelected,
                colorUnselected: colorUnselected,
                iconData: Icons.home_outlined,
                label: 'Home',
                isSelected: navigationController.currentIndex ==
                    NavigationTabs.home.index,
              ),
            ),
            BottomBarItem(
              iconBuilder: (color) => CustomBottomBarItem(
                colorSelected: colorSelected,
                colorUnselected: colorUnselected,
                iconData: Icons.shopping_cart_outlined,
                label: 'Carrinho',
                isSelected: navigationController.currentIndex ==
                    NavigationTabs.cart.index,
              ),
            ),
            BottomBarItem(
              iconBuilder: (color) => CustomBottomBarItem(
                colorSelected: colorSelected,
                colorUnselected: colorUnselected,
                iconData: Icons.list_outlined,
                label: 'Pedidos',
                isSelected: navigationController.currentIndex ==
                    NavigationTabs.orders.index,
              ),
            ),
            BottomBarItem(
              iconBuilder: (color) => CustomBottomBarItem(
                colorSelected: colorSelected,
                colorUnselected: colorUnselected,
                iconData: Icons.person_outline,
                label: 'Perfil',
                isSelected: navigationController.currentIndex ==
                    NavigationTabs.profile.index,
              ),
            ),
          ],
          onSelect: (page) {
            navigationController.navigatePageView(page: page);
          },
        );
      }),
    );
  }
}
