import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/not_item_found.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/l10n.dart';
import '../../../../05_home_view/presentation/view_model/favourite_product_cubit/favourite_product_cubit.dart';
import 'favourite_view_item.dart';

class FavouriteViewBody extends StatelessWidget {
  const FavouriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomLayout(
      mobileWidget: FavouriteViewBodyMobile(),
      tabletWidget: FavouriteViewBodyTablet(),
    );
  }
}

class FavouriteViewBodyMobile extends StatelessWidget {
  const FavouriteViewBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteProductCubit, FavouriteProductState>(
      listener: (context, state) {
        if (state is DeleteFavouriteProductSuccess) {
          context.read<FavouriteProductCubit>().getFavouriteProducts();
        }
      },
      builder: (context, state) {
        if (state is GetFavouriteProductsSuccess) {
          final favourites = state.favouriteList;
          if (favourites.isEmpty) {
            return Center(
              child: NoItemFound(
                itemTitle: S.of(context).profileNoFavourite,
                itemImage: Assets.profileUnFavouriteHeart,
              ),
            );
          }
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemCount: favourites.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemBuilder: (context, index) {
                  final item = favourites[index];
                  return InkWell(
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).push(Routes.productDetailsView, extra: item.id);
                    },
                    child: FavouriteViewItem(productModel: item),
                  );
                },
              ),
            ),
          );
        } else if (state is GetFavouriteProductsFailure) {
          return Center(
            child: CustomText(
              text: state.errorMessage,
              fontSize: 18,
              alignment: Alignment.center,
            ),
          );
        } else {
          return const CustomCircleIndicator(color: kPrimaryColor);
        }
      },
    );
  }
}

class FavouriteViewBodyTablet extends StatelessWidget {
  const FavouriteViewBodyTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteProductCubit, FavouriteProductState>(
      listener: (context, state) {
        if (state is DeleteFavouriteProductSuccess) {
          context.read<FavouriteProductCubit>().getFavouriteProducts();
        }
      },
      builder: (context, state) {
        if (state is GetFavouriteProductsSuccess) {
          final favourites = state.favouriteList;
          if (favourites.isEmpty) {
            return Center(
              child: NoItemFound(
                itemTitle: S.of(context).profileNoFavourite,
                itemImage: Assets.profileUnFavouriteHeart,
              ),
            );
          }
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: state.favouriteList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  final item = state.favouriteList[index];
                  return InkWell(
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).push(Routes.productDetailsView, extra: item.id);
                    },
                    child: FavouriteViewItem(productModel: item),
                  );
                },
              ),
            ),
          );
        } else if (state is GetFavouriteProductsFailure) {
          return Center(
            child: CustomText(
              text: state.errorMessage,
              fontSize: 18,
              alignment: Alignment.center,
            ),
          );
        } else {
          return const CustomCircleIndicator(color: kPrimaryColor);
        }
      },
    );
  }
}
