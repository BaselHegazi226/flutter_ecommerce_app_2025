import 'package:flutter/material.dart';

import '../../../../../core/utilities/custom_text.dart';

class AboutUsItem extends StatelessWidget {
  const AboutUsItem({super.key, required this.title, required this.value});

  final String title;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        CustomText(text: title, fontSize: 16, fontWeight: FontWeight.w600),
        value,
      ],
    );
  }
}
