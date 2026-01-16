import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';
import 'package:go_router/go_router.dart';

import '../../../data/model/favourite_model.dart';
import '../../view_model/favourite_product_cubit/favourite_product_cubit.dart';

class ProductDetailsIconSection extends StatelessWidget {
  const ProductDetailsIconSection({super.key, required this.favouriteModel});

  final FavouriteModel favouriteModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconWithCircleStyle(
          paddingValue: 0,
          backgroundColor: Colors.grey.shade500.withAlpha(32),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 20),
        ),
        BlocBuilder<FavouriteProductCubit, FavouriteProductState>(
          builder: (context, state) {
            final isFavourite =
                state is AddFavouriteProductSuccess ||
                state is GetFavouriteProductByIdSuccess;

            return IconWithCircleStyle(
              backgroundColor: isFavourite
                  ? Colors.grey.shade500.withAlpha(64)
                  : Colors.grey.shade500.withAlpha(32),
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
              onPressed: () {
                if (!isFavourite) {
                  context.read<FavouriteProductCubit>().addFavoriteProduct(
                    favouriteModel: favouriteModel,
                  );
                } else {
                  context.read<FavouriteProductCubit>().deleteFavoriteProduct(
                    favouriteModel: favouriteModel,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
