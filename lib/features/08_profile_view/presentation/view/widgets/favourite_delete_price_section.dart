import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/data/model/favourite_model.dart';

import '../../../../../generated/l10n.dart';
import 'favourite_delete_section.dart';

class FavouriteDeletePriceSection extends StatelessWidget {
  const FavouriteDeletePriceSection({
    super.key,
    required this.favouriteModel,
    required this.fontSize,
  });

  final double fontSize;
  final FavouriteModel favouriteModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: '${priceShowed(favouriteModel.price)} ${S.of(context).EP}',
          fontSize: 12,
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
        FavouriteDeleteSection(favouriteModel: favouriteModel),
      ],
    );
  }
}
