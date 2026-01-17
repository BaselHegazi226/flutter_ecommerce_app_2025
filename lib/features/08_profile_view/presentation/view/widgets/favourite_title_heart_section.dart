import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

import 'favourite_heart_section.dart';

class FavouriteTitleHeartSection extends StatelessWidget {
  const FavouriteTitleHeartSection({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: title,
          maxLines: 1,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        const FavouriteHeartSection(),
      ],
    );
  }
}
