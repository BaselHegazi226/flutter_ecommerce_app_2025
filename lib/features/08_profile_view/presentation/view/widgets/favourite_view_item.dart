import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/data/model/favourite_model.dart';

import 'favourite_delete_price_section.dart';
import 'favourite_heart_section.dart';
import 'favourite_item_custom_image.dart';

class FavouriteViewItem extends StatelessWidget {
  const FavouriteViewItem({super.key, required this.favouriteModel});

  final FavouriteModel favouriteModel;

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      mobileWidget: FavouriteViewItemMobile(favouriteModel: favouriteModel),
      tabletWidget: FavouriteViewItemTablet(favouriteModel: favouriteModel),
    );
  }
}

class FavouriteViewItemMobile extends StatelessWidget {
  const FavouriteViewItemMobile({super.key, required this.favouriteModel});

  final FavouriteModel favouriteModel;
  static const double _itemHeight = 176;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _itemHeight,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: Colors.grey.shade500.withAlpha(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FavouriteItemCustomImage(
              imageUrl: favouriteModel.image,
              itemHeight: _itemHeight,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(flex: 2, child: _detailsSection(context)),
        ],
      ),
    );
  }

  Widget _detailsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 16,
        children: [
          _heartTitleSection(),
          CustomText(text: favouriteModel.desc, maxLines: 3, fontSize: 12),
          FavouriteDeletePriceSection(
            favouriteModel: favouriteModel,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  Widget _heartTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: favouriteModel.title.split(" ").take(2).join(" ").length < 15
              ? favouriteModel.title.split(" ").take(2).join(" ")
              : favouriteModel.title.split(" ").take(1).join(" "),
          maxLines: 1,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        const FavouriteHeartSection(),
      ],
    );
  }
}

class FavouriteViewItemTablet extends StatelessWidget {
  const FavouriteViewItemTablet({super.key, required this.favouriteModel});

  final FavouriteModel favouriteModel;
  static const double _itemHeight = 240;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: _itemHeight,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: Colors.grey.shade500.withAlpha(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FavouriteItemCustomImage(
              imageUrl: favouriteModel.image,
              itemHeight: _itemHeight,
              paddingValue: 12,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(flex: 2, child: _detailsSection(context, size)),
        ],
      ),
    );
  }

  Widget _detailsSection(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _heartTitleSection(),
          SizedBox(
            width: size.width * .55,
            child: CustomText(
              text: favouriteModel.desc,
              maxLines: 4,
              fontSize: 12,
            ),
          ),
          FavouriteDeletePriceSection(
            favouriteModel: favouriteModel,
            fontSize: 14,
          ),
        ],
      ),
    );
  }

  Widget _heartTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: favouriteModel.title.split(" ").take(2).join(" ").length < 15
              ? favouriteModel.title.split(" ").take(2).join(" ")
              : favouriteModel.title.split(" ").take(1).join(" "),
          maxLines: 1,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        const FavouriteHeartSection(),
      ],
    );
  }
}
