import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/screens/common_widgets/components/quantity_button.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
    required this.quantity,
    required this.suffixText,
    required this.isRemovable,
    required this.result,
  });

  final int quantity;
  final String suffixText;
  final Function(int quantity) result;
  final bool isRemovable;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
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
          mainAxisSize: MainAxisSize.min,
          children: [
            QuantityButton(
              iconData: !widget.isRemovable || widget.quantity > 1
                  ? Icons.remove
                  : Icons.delete_forever,
              color: !widget.isRemovable || widget.quantity > 1
                  ? Colors.grey
                  : Colors.red,
              onTap: () {
                if (widget.quantity == 1 && !widget.isRemovable) {
                  return;
                }
                int resultCount = widget.quantity - 1;
                widget.result(resultCount);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '${widget.quantity} ${widget.suffixText}',
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
                int resultCount = widget.quantity + 1;
                widget.result(resultCount);
              },
            ),
          ],
        ),
      ),
    );
  }
}
