import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/helpers/utils.dart';
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
  @override
  Widget build(BuildContext context) {
    Color colorSelected = Colors.white;
    Color colorUnselected = Colors.white.withAlpha(100);

    return Scaffold(
      body: PageView(
        controller: Utils.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) => setState(() {}),
        children: const [
          HomeTab(),
          CartTab(),
          OrdersTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomBarDoubleBullet(
        backgroundColor: CustomColors.customSwathColor,
        circle1Color: Colors.red,
        circle2Color: Colors.blue,
        color: Colors.white,
        selectedIndex: Utils.selectedPage,
        items: [
          BottomBarItem(
            iconBuilder: (color) => CustomBottomBarItem(
              colorSelected: colorSelected,
              colorUnselected: colorUnselected,
              iconData: Icons.home_outlined,
              label: 'Home',
              isSelected: Utils.selectedPage == 0,
            ),
          ),
          BottomBarItem(
            iconBuilder: (color) => CustomBottomBarItem(
              colorSelected: colorSelected,
              colorUnselected: colorUnselected,
              iconData: Icons.shopping_cart_outlined,
              label: 'Carrinho',
              isSelected: Utils.selectedPage == 1,
            ),
          ),
          BottomBarItem(
            iconBuilder: (color) => CustomBottomBarItem(
              colorSelected: colorSelected,
              colorUnselected: colorUnselected,
              iconData: Icons.list_outlined,
              label: 'Pedidos',
              isSelected: Utils.selectedPage == 2,
            ),
          ),
          BottomBarItem(
            iconBuilder: (color) => CustomBottomBarItem(
              colorSelected: colorSelected,
              colorUnselected: colorUnselected,
              iconData: Icons.person_outline,
              label: 'Perfil',
              isSelected: Utils.selectedPage == 3,
            ),
          ),
        ],
        onSelect: (value) {
          Utils.selectedPage = value;
          Utils.pageController.jumpToPage(Utils.selectedPage);
        },
      ),
    );
  }
}
