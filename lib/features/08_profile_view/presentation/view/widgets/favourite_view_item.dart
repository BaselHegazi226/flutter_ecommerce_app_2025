import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/data/model/favourite_model.dart';

import '../../../../../core/utilities/custom_dialog_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../05_home_view/presentation/view_model/favourite_product_cubit/favourite_product_cubit.dart';
import 'favourite_delete_section.dart';

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
          Expanded(child: _customImage(context, favouriteModel.image)),
          const SizedBox(width: 20),
          Expanded(flex: 2, child: _detailsSection(context)),
        ],
      ),
    );
  }

  Widget _detailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: 16,
      children: [
        _titleHeartSection(),
        _descPriceSection(context),
        _buildPriceDeleteSection(context),
      ],
    );
  }

  Widget _titleHeartSection() {
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
        buildHeartIcon(),
      ],
    );
  }

  Column _descPriceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: favouriteModel.desc, maxLines: 3, fontSize: 12),
      ],
    );
  }

  _buildPriceDeleteSection(BuildContext context) {
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
                  favouriteModel: favouriteModel,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade400.withAlpha(32),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        errorWidget: (context, url, error) {
          return const Icon(Icons.image_not_supported_outlined);
        },
        imageUrl: imageUrl,
      ),
    );
  }
}

class FavouriteViewItemTablet extends StatelessWidget {
  const FavouriteViewItemTablet({super.key, required this.favouriteModel});

  final FavouriteModel favouriteModel;
  static const double _itemHeight = 234;

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
          Expanded(child: _customImage(context, favouriteModel.image)),
          const SizedBox(width: 24),
          Expanded(flex: 2, child: _detailsSection(context)),
        ],
      ),
    );
  }

  Widget _detailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: 16,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_titleHeartSection(), _descPriceSection(context)],
        ),
        _priceDeleteSection(context),
      ],
    );
  }

  Widget _titleHeartSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomText(
            text: favouriteModel.title.split(" ").take(4).join(" "),
            maxLines: 1,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        buildHeartIcon(),
      ],
    );
  }

  Column _descPriceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: favouriteModel.desc, fontSize: 14),
        const SizedBox(height: 8),
      ],
    );
  }

  Row _priceDeleteSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: '${priceShowed(favouriteModel.price)} ${S.of(context).EP}',
          fontSize: 14,
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
        FavouriteDeleteSection(favouriteModel: favouriteModel),
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
                  favouriteModel: favouriteModel,
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
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade400.withAlpha(32)
            : Colors.grey.shade700.withAlpha(32),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        errorWidget: (context, url, error) {
          return const Icon(Icons.image_not_supported_outlined);
        },
        imageUrl: imageUrl,
      ),
    );
  }
}
