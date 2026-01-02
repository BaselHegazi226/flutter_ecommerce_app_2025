import 'package:flutter/material.dart';

import '../../../../../core/utilities/custom_text.dart';

class CustomTitleValueItem extends StatelessWidget {
  const CustomTitleValueItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: const Color(0xffEBEBEB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          CustomText(
            text: title,
            fontSize: 14,
            alignment: Alignment.centerLeft,
          ),
          value,
        ],
      ),
    );
  }
}
