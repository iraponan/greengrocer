import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton(
      {super.key,
      required this.iconData,
      required this.color,
      required this.onTap});

  final IconData iconData;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
