import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/cart_items.dart';
import 'package:greengrocer/src/controllers/home.dart';
import 'package:greengrocer/src/controllers/navigation.dart';
import 'package:greengrocer/src/helpers/enums/navigation_tabs.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/screens/common_widgets/app_name.dart';
import 'package:greengrocer/src/screens/common_widgets/custom_shimmer.dart';
import 'package:greengrocer/src/screens/home/components/category_tile.dart';
import 'package:greengrocer/src/screens/home/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Function(GlobalKey) runAddToCartAnimation;

  final searchController = TextEditingController();
  final cartItemsController = Get.find<CartItemsController>();
  final navigationController = Get.find<NavigationController>();

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
            child: GetBuilder<CartItemsController>(builder: (controller) {
              MethodsUtils.updateIconCart(cartItemsController);
              return GestureDetector(
                onTap: () {
                  navigationController.navigatePageView(
                      page: NavigationTabs.cart.index);
                },
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
              );
            }),
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
            GetBuilder<HomeController>(builder: (controller) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    controller.searchProductName.value = value;
                  },
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
                    suffixIcon: controller.searchProductName.value.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              searchController.clear();
                              controller.searchProductName.value = '';
                              FocusScope.of(context).unfocus();
                            },
                            icon: Icon(
                              Icons.close,
                              color: CustomColors.customContrastColor,
                            ),
                          )
                        : null,
                  ),
                ),
              );
            }),
            // # Categorias #
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  padding: const EdgeInsets.only(left: 25),
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CategoryTile(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              controller.selectCategory(
                                  controller.allCategories[index]);
                            },
                            category: controller.allCategories[index].name,
                            isSelected: controller.allCategories[index] ==
                                controller.currentCategory,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                          itemCount: controller.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            controller.allCategories.length,
                            (index) => Container(
                              margin: const EdgeInsets.only(right: 12),
                              alignment: Alignment.center,
                              child: CustomShimmer(
                                height: 30,
                                width: 80,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            // # Grid View #
            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isProductLoading
                      ? Visibility(
                          visible: (controller.products).isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 150,
                                color: CustomColors.customSwathColor,
                              ),
                              const Text(
                                'Não há produtos para apresentar.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5,
                            ),
                            itemCount: controller.products.length,
                            itemBuilder: (context, index) {
                              if ((index + 1) == controller.products.length &&
                                  !controller.isLastPage) {
                                controller.loadMoreProducts();
                              }
                              return ItemTile(
                                product: controller.products[index],
                                cartAnimationMethod: itemSelectedCartAnimations,
                              );
                            },
                          ),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                            controller.products.length,
                            (index) => CustomShimmer(
                              height: double.infinity,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void itemSelectedCartAnimations(GlobalKey gkImage) async {
    await runAddToCartAnimation(gkImage);
    MethodsUtils.updateIconCart(cartItemsController);
  }
}
