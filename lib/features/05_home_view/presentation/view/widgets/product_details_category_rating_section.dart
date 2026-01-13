import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';

import '../../../../../core/utilities/custom_text.dart';
import '../../../../../generated/l10n.dart';
import 'custom_title_value.dart';

class ProductDetailsCategoryRatingSection extends StatelessWidget {
  const ProductDetailsCategoryRatingSection({
    super.key,
    required this.category,
    required this.rating,
    //required this.id,
  });

  final String category;
  final double rating;

  //final int id;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      children: [
        CustomTitleValueItem(
          title: S.of(context).homeCategory,
          value: CustomText(
            text: category,
            fontSize: 14,
            alignment: Alignment.centerRight,
            color: kGreyColor,
          ),
        ),
        const SizedBox(width: 4),
        CustomTitleValueItem(
          title: S.of(context).homeRating,
          value: starFunctionLikeGooglePlay(context, rating: rating),
        ),
      ],
    );
  }
}
