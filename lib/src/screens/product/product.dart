import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/cart_items.dart';
import 'package:greengrocer/src/controllers/navigation.dart';
import 'package:greengrocer/src/helpers/enums/navigation_tabs.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/product.dart';
import 'package:greengrocer/src/screens/common_widgets/quantity_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final Product product = Get.arguments;
  final navigationController = Get.find<NavigationController>();
  final cartItemsController = Get.find<CartItemsController>();

  int cartItemQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          // # Conteúdo #
          Column(
            children: [
              // # Imagem #
              Expanded(
                child: Hero(
                  tag: product.imgUrl,
                  child: Image.network(product.imgUrl),
                ),
              ),
              // # Conteúdo #
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // # Nome do Produto #
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // # Quantidade #
                          QuantityWidget(
                            quantity: cartItemQuantity,
                            suffixText: product.unit,
                            isRemovable: false,
                            result: (quantity) => setState(() {
                              cartItemQuantity = quantity;
                            }),
                          ),
                        ],
                      ),
                      // # Preço #
                      Text(
                        UtilBrasilFields.obterReal(
                          product.price,
                          moeda: true,
                        ),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwathColor,
                        ),
                      ),
                      // # Descrição #
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            child: Text(
                              product.description,
                              style: const TextStyle(
                                height: 1.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                      // # Botão #
                      SizedBox(
                        height: VariablesUtils.heightButton,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            cartItemsController.addItemToCart(
                              product: product,
                              quantity: cartItemQuantity,
                            );
                            if (await showAddProductConfirmation(context) ??
                                false) {
                              Get.back();
                            } else {
                              Get.back();
                              navigationController.navigatePageView(
                                  page: NavigationTabs.cart.index);
                            }
                            MethodsUtils.updateIconCart(cartItemsController);
                          },
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                          ),
                          label: const Text(
                            'Add Ao Carrinho',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showAddProductConfirmation(BuildContext context) =>
      showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja continuar comprando?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Não',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Sim'),
            ),
          ],
        ),
      );
}
