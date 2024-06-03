import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/data/items.dart' as items_data;
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/helpers/utils/variables.dart';
import 'package:greengrocer/src/screens/common_widgets/app_name.dart';
import 'package:greengrocer/src/screens/home/components/category_tile.dart';
import 'package:greengrocer/src/screens/home/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Function(GlobalKey) runAddToCartAnimation;

  String selectedCategory = 'Frutas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // # App Bar #
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: GestureDetector(
          onTap: () => MethodsUtils.showToast(
              message: 'Esse é um App para um Mercadinho.'),
          child: const AppName(),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {},
              child: AddToCartIcon(
                  key: VariablesUtils.globalKeyCartItems,
                  badgeOptions: BadgeOptions(
                    active: true,
                    backgroundColor: CustomColors.customContrastColor,
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwathColor,
                  )),
            ),
          ),
        ],
      ),
      body: AddToCartAnimation(
        cartKey: VariablesUtils.globalKeyCartItems,
        jumpAnimation: const JumpAnimationOptions(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
          active: true,
        ),
        dragAnimation: const DragToCartAnimationOptions(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
          rotation: true,
        ),
        createAddToCartAnimation: (addToCartAnimation) {
          runAddToCartAnimation = addToCartAnimation;
        },
        child: Column(
          children: [
            // # Campo de Pesquisa #
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Pesquise aqui...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.customContrastColor,
                    size: 21,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
            // # Categorias #
            Container(
              padding: const EdgeInsets.only(left: 25),
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CategoryTile(
                  onTap: () {
                    setState(() {
                      selectedCategory = items_data.categories[index];
                    });
                  },
                  category: items_data.categories[index],
                  isSelected: items_data.categories[index] == selectedCategory,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: items_data.categories.length,
              ),
            ),
            // # Grid View #
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 9 / 11.5,
                ),
                itemCount: items_data.items.length,
                itemBuilder: (context, index) => ItemTile(
                  item: items_data.items[index],
                  cartAnimationMethod: itemSelectedCartAnimations,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void itemSelectedCartAnimations(GlobalKey gkImage) async {
    await runAddToCartAnimation(gkImage);
    await VariablesUtils.globalKeyCartItems.currentState!
        .runCartAnimation((++VariablesUtils.cartQuantityItems).toString());
  }
}
