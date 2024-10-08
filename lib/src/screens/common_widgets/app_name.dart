import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
    this.greenTitleColor,
    this.textSize = 30,
  });

  final Color? greenTitleColor;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: 'Green',
            style: TextStyle(
              color: greenTitleColor ?? CustomColors.customSwathColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'grocer',
            style: TextStyle(
              color: CustomColors.customContrastColor,
            ),
          ),
        ],
      ),
    );
  }
}
