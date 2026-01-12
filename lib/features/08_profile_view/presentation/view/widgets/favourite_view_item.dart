import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';

import '../../../../../core/utilities/custom_dialog_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../05_home_view/data/model/product_model.dart';
import '../../../../05_home_view/presentation/view_model/favourite_product_cubit/favourite_product_cubit.dart';

class FavouriteViewItem extends StatelessWidget {
  const FavouriteViewItem({super.key, required this.productModel});

  final ProductModel productModel;
  static const double _itemHeight = 224;

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
          Expanded(child: _customImage(context, productModel.images[0])),
          const SizedBox(width: 16),
          Expanded(flex: 2, child: _detailsSection(context)),
        ],
      ),
    );
  }

  Widget _detailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 8,
      children: [_titleHeartSection(), _descPriceSection(context)],
    );
  }

  Widget _titleHeartSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: productModel.title,
          maxLines: 1,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        buildHeartIcon(),
      ],
    );
  }

  Column _descPriceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: productModel.description, maxLines: 6, fontSize: 14),
        const SizedBox(height: 8),
        CustomText(
          text: '${priceShowed(productModel.price)} ${S.of(context).EP}',
          fontSize: 14,
          color: kPrimaryColor,
        ),
      ],
    );
  }

  BlocConsumer<FavouriteProductCubit, FavouriteProductState> buildHeartIcon() {
    return BlocConsumer<FavouriteProductCubit, FavouriteProductState>(
      listener: (context, state) {
        if (state is DeleteFavouriteProductSuccess ||
            state is GetFavouriteProductByIdSuccess) {
        } else if (state is AddFavouriteProductFailure ||
            state is GetFavouriteProductByIdFailure) {}
      },
      builder: (context, state) {
        final isFavourite = state is GetFavouriteProductsSuccess;
        return IconWithCircleStyle(
          backgroundColor: Colors.grey.shade400.withAlpha(32),
          icon: Icon(
            isFavourite
                ? Icons.favorite_outlined
                : Icons.favorite_border_outlined,
            color: isFavourite
                ? Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.red.shade500
                : Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            size: 18,
          ),
          onPressed: () {
            warningAwesomeDialog(
              context,
              title: S.of(context).profileDeleteItemTitle,
              description: S.of(context).profileDeleteItemDesc,
              buttonAcceptText: S.of(context).warning_button_title_ok,
              buttonCancelText: S.of(context).warning_button_title_Cancel,
              onPressed: () {
                context.read<FavouriteProductCubit>().deleteFavoriteProduct(
                  productModel: productModel,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _customImage(BuildContext context, String imageUrl) {
    return Container(
      height: _itemHeight,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade400.withAlpha(32)
            : Colors.grey.shade700.withAlpha(32),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return const Icon(Icons.image_not_supported_outlined);
        },
        imageUrl: imageUrl,
      ),
    );
  }
}
