import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

class CheckItem extends StatelessWidget {
  const CheckItem({super.key, required this.itemText, required this.isValid});

  final String itemText;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          isValid
              ? Icons.check_circle_outline_outlined
              : Icons.error_outline_outlined,
          color: isValid ? Colors.green : const Color(0x993C3C43),
          size: 16,
        ),
        CustomText(
          text: itemText,
          fontSize: 8,
          color: isValid ? Colors.green : const Color(0x993C3C43),
        ),
      ],
    );
  }
}
