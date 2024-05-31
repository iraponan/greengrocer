import 'package:flutter/material.dart';

class CustomBottomBarItem extends StatelessWidget {
  const CustomBottomBarItem({
    super.key,
    required this.colorSelected,
    required this.colorUnselected,
    required this.iconData,
    required this.label,
    required this.isSelected,
  });

  final Color colorSelected;
  final Color colorUnselected;
  final IconData iconData;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: isSelected ? colorSelected : colorUnselected,
          size: 30,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.transparent,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            decoration:
                isSelected ? TextDecoration.underline : TextDecoration.none,
            decorationThickness: 2,
            decorationColor: isSelected ? colorSelected : colorUnselected,
            shadows: [
              Shadow(
                color: isSelected ? colorSelected : colorUnselected,
                offset: const Offset(0, -5),
              ),
            ],
          ),
        )
      ],
    );
  }
}
