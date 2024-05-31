import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/screens/base/components/custom_bottom_bar_item.dart';
import 'package:greengrocer/src/screens/home/home_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    int selectedPage = 0;
    Color colorSelected = Colors.white;
    Color colorUnselected = Colors.white.withAlpha(100);

    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeTab(),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.purple,
          ),
        ],
      ),
      bottomNavigationBar: BottomBarDoubleBullet(
        backgroundColor: CustomColors.customSwathColor.shade900,
        circle1Color: Colors.red,
        circle2Color: Colors.blue,
        color: Colors.white,
        selectedIndex: selectedPage,
        items: [
          BottomBarItem(
            iconBuilder: (color) => CustomBottomBarItem(
              colorSelected: colorSelected,
              colorUnselected: colorUnselected,
              iconData: Icons.home_outlined,
              label: 'Home',
              isSelected: selectedPage == 0,
            ),
          ),
          BottomBarItem(
            iconBuilder: (color) => CustomBottomBarItem(
              colorSelected: colorSelected,
              colorUnselected: colorUnselected,
              iconData: Icons.shopping_cart_outlined,
              label: 'Carrinho',
              isSelected: selectedPage == 1,
            ),
          ),
          BottomBarItem(
            iconBuilder: (color) => CustomBottomBarItem(
              colorSelected: colorSelected,
              colorUnselected: colorUnselected,
              iconData: Icons.list_outlined,
              label: 'Pedidos',
              isSelected: selectedPage == 2,
            ),
          ),
          BottomBarItem(
            iconBuilder: (color) => CustomBottomBarItem(
              colorSelected: colorSelected,
              colorUnselected: colorUnselected,
              iconData: Icons.person_outline,
              label: 'Perfil',
              isSelected: selectedPage == 3,
            ),
          ),
        ],
        onSelect: (value) {
          selectedPage = value;
          pageController.jumpToPage(selectedPage);
        },
      ),
    );
  }
}
