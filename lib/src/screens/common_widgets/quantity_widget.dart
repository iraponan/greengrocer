import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/screens/common_widgets/components/quantity_button.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    super.key,
    required this.quantity,
    required this.suffixText,
    required this.result,
  });

  final int quantity;
  final String suffixText;
  final Function(int quantity) result;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(230),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          children: [
            QuantityButton(
              iconData: Icons.remove,
              color: Colors.grey,
              onTap: () {
                if (quantity == 1) {
                  return;
                }
                int resultCount = quantity - 1;
                result(resultCount);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '$quantity $suffixText',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            QuantityButton(
              iconData: Icons.add,
              color: CustomColors.customSwathColor,
              onTap: () {
                int resultCount = quantity + 1;
                result(resultCount);
              },
            ),
          ],
        ),
      ),
    );
  }
}
