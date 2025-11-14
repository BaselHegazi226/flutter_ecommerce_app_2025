import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/favourite_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/not_item_found.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/favourite_product_cubit/favourite_product_cubit.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utilities/custom_dialog_state.dart';
import '../../../../generated/l10n.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteProductCubit(
        favouriteCache: AppGet().getIt<FavouriteCacheImplement>(),
      )..getFavouriteProducts(),
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(context, S.of(context).Favourite, () {
            GoRouter.of(context).pushReplacement(Routes.profileView);
          }),
          body: const FavouriteViewBody(),
        ),
      ),
    );
  }
}

class FavouriteViewBody extends StatelessWidget {
  const FavouriteViewBody({super.key});

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
                itemTitle: S.of(context).NoFavouriteItemFound,
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
                  debugPrint('image = ${item.images[0]}');
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

class FavouriteViewItem extends StatelessWidget {
  const FavouriteViewItem({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade500
            : Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade400
                : Colors.grey.shade50,
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _customImage(productModel.images[0])),
          const SizedBox(width: 16),
          Expanded(flex: 2, child: _detailsSection()),
        ],
      ),
    );
  }

  Widget _customImage(String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: AspectRatio(
        aspectRatio: .75,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          errorWidget: (context, url, error) {
            debugPrint('error for image = $error');
            return const Icon(Icons.image_not_supported_outlined);
          },
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  Widget _detailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 4,
          children: [
            Flexible(
              child: CustomText(
                text: productModel.title,
                maxLines: 1,
                fontSize: 16,
                alignment: Alignment.center,
                color: Colors.grey.shade900,
              ),
            ),
            BlocConsumer<FavouriteProductCubit, FavouriteProductState>(
              listener: (context, state) {
                if (state is DeleteFavouriteProductSuccess ||
                    state is GetFavouriteProductByIdSuccess) {
                  debugPrint(
                    'success add product to favourite list ==========================>',
                  );
                } else if (state is AddFavouriteProductFailure ||
                    state is GetFavouriteProductByIdFailure) {
                  debugPrint(
                    'Failure add product to favourite list ==========================>',
                  );
                }
              },
              builder: (context, state) {
                final isFavourite = state is GetFavouriteProductsSuccess;
                debugPrint('isFavourite = $isFavourite');
                return Flexible(
                  child: IconWithCircleStyle(
                    backgroundColor: Colors.grey.shade400.withAlpha(32),
                    widget: IconButton(
                      padding: const EdgeInsets.all(4),
                      onPressed: () {
                        warningAwesomeDialog(
                          context,
                          title: 'Delete Favourite Item',
                          description: 'Are you sure to delete favourite item?',
                          buttonAcceptText: 'Ok',
                          buttonCancelText: 'Cancel',
                          onPressed: () {
                            context
                                .read<FavouriteProductCubit>()
                                .deleteFavoriteProduct(
                                  productModel: productModel,
                                );
                          },
                        );
                      },
                      icon: Icon(
                        isFavourite
                            ? Icons.favorite_outlined
                            : Icons.favorite_border_outlined,
                        color: isFavourite ? Colors.red.shade500 : Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        CustomText(text: productModel.description, fontSize: 14, maxLines: 4),
        const SizedBox(height: 8),
        CustomText(
          text: '\$ ${productModel.price}',
          fontSize: 14,
          color: kPrimaryColor,
        ),
      ],
    );
  }
}
