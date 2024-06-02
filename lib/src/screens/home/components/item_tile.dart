import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/item.dart';
import 'package:greengrocer/src/screens/product/product.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.item,
    required this.cartAnimationMethod,
  });

  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  @override
  Widget build(BuildContext context) {
    final GlobalKey imageGk = GlobalKey();

    return Stack(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) => ProductScreen(item: item),
            ),
          ),
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
                      tag: item.imgUrl,
                      child: Container(
                        key: imageGk,
                        child: Image.asset(
                          item.imgUrl,
                        ),
                      ),
                    ),
                  ),
                  // # Nome do produto #
                  Text(
                    item.itemName,
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
                          item.price,
                          moeda: true,
                        ),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: CustomColors.customSwathColor),
                      ),
                      Text(
                        '/${item.unit}',
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
          child: InkWell(
            onTap: () => cartAnimationMethod(imageGk),
            child: Container(
              height: 40,
              width: 35,
              decoration: BoxDecoration(
                color: CustomColors.customSwathColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
