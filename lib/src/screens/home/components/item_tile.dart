import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/config/page_routes.dart';
import 'package:greengrocer/src/controllers/cart_items.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/models/product.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    super.key,
    required this.product,
    required this.cartAnimationMethod,
  });

  final Product product;
  final void Function(GlobalKey) cartAnimationMethod;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final cartItemsController = Get.find<CartItemsController>();

  IconData tileIcon = VariablesUtils.tileIconDefault;

  @override
  Widget build(BuildContext context) {
    final GlobalKey imageGk = GlobalKey();

    return Stack(
      children: [
        InkWell(
          onTap: () =>
              Get.toNamed(PageRoutes.productRoute, arguments: widget.product),
          child: Card(
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // # Imagem #
                  Expanded(
                    child: Hero(
                      tag: widget.product.imgUrl,
                      child: Container(
                        key: imageGk,
                        child: Image.network(
                          widget.product.imgUrl,
                        ),
                      ),
                    ),
                  ),
                  // # Nome do produto #
                  Text(
                    widget.product.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // # Preço do Produto - Unidade #
                  Row(
                    children: [
                      Text(
                        UtilBrasilFields.obterReal(
                          widget.product.price,
                          moeda: true,
                        ),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: CustomColors.customSwathColor),
                      ),
                      Text(
                        '/${widget.product.unit}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: Material(
              child: InkWell(
                onTap: () {
                  widget.cartAnimationMethod(imageGk);
                  cartItemsController.addItemToCart(product: widget.product);
                  switchIcon();
                },
                child: Ink(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                    color: CustomColors.customSwathColor,
                  ),
                  child: Icon(
                    tileIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> switchIcon() async {
    setState(() => tileIcon = VariablesUtils.tileIconCheckDefault);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => tileIcon = VariablesUtils.tileIconDefault);
  }
}
