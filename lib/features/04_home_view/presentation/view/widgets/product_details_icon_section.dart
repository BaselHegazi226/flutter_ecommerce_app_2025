import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/favourite_product_cubit/favourite_product_cubit.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsIconSection extends StatelessWidget {
  const ProductDetailsIconSection({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconWithCircleStyle(
          backgroundColor: Colors.grey.shade500.withAlpha(32),
          widget: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 20),
          ),
        ),
        BlocConsumer<FavouriteProductCubit, FavouriteProductState>(
          listener: (context, state) {
            if (state is AddFavouriteProductSuccess ||
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
            final isFavourite =
                state is AddFavouriteProductSuccess ||
                state is GetFavouriteProductByIdSuccess;

            return IconWithCircleStyle(
              backgroundColor: isFavourite
                  ? Colors.grey.shade500.withAlpha(64)
                  : Colors.grey.shade500.withAlpha(32),

              widget: IconButton(
                padding: const EdgeInsets.all(4),
                onPressed: () {
                  if (!isFavourite) {
                    context.read<FavouriteProductCubit>().addFavoriteProduct(
                      productModel: productModel,
                    );
                  } else {
                    context.read<FavouriteProductCubit>().deleteFavoriteProduct(
                      productModel: productModel,
                    );
                  }
                },
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
                  size: 20,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
