import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class StatusDot extends StatelessWidget {
  const StatusDot({
    super.key,
    required this.isActive,
    required this.title,
    this.backgroundColor,
  });

  final bool isActive;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: CustomColors.customSwathColor,
            ),
            color: isActive
                ? backgroundColor ?? CustomColors.customSwathColor
                : Colors.transparent,
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  size: 13,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
