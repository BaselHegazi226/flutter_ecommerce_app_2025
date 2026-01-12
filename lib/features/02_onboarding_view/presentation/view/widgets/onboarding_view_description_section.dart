import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

class OnBoardingViewDescriptionSection extends StatelessWidget {
  const OnBoardingViewDescriptionSection({
    super.key,
    required this.title1,

    required this.subTitle,
  });

  final String title1, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        CustomText(text: title1, fontSize: 24),
        CustomText(text: subTitle, fontSize: 16),
      ],
    );
  }
}
