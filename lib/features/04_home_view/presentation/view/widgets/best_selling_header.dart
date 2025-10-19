import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

class BestSellingHeader extends StatelessWidget {
  const BestSellingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: 'Best Selling',
          fontSize: 18,
          alignment: Alignment.topLeft,
        ),
        CustomText(
          text: 'See All',
          fontSize: 18,
          alignment: Alignment.topRight,
        ),
      ],
    );
  }
}
