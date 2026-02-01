import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/data/model/favourite_model.dart';

import 'favourite_delete_price_section.dart';
import 'favourite_item_custom_image.dart';
import 'favourite_title_heart_section.dart';

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
      padding: const EdgeInsets.all(8),
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
          const SizedBox(width: 20),
          Expanded(flex: 2, child: _detailsSection(context)),
        ],
      ),
    );
  }

  Widget _detailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        FavouriteTitleHeartSection(
          title: favouriteModel.title.split(" ").take(2).join(" ").length < 15
              ? favouriteModel.title.split(" ").take(2).join(" ")
              : favouriteModel.title.split(" ").take(1).join(" "),
        ),
        CustomText(text: favouriteModel.desc, maxLines: 3, fontSize: 12),
        FavouriteDeletePriceSection(
          favouriteModel: favouriteModel,
          fontSize: 12,
        ),
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
      padding: const EdgeInsets.all(16),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //spacing: 16,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FavouriteTitleHeartSection(
              title: favouriteModel.title.split(" ").take(4).join(" "),
            ),
            SizedBox(
              width: size.width * .3,
              child: CustomText(
                text: favouriteModel.desc,
                maxLines: 4,
                fontSize: 14,
              ),
            ),
          ],
        ),
        FavouriteDeletePriceSection(
          favouriteModel: favouriteModel,
          fontSize: 14,
        ),
      ],
    );
  }
}
