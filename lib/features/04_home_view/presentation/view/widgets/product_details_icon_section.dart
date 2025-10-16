import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/favourite_product_cubit/favourite_product_cubit.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsIconSection extends StatelessWidget {
  const ProductDetailsIconSection({
    super.key,
    required this.screenSize,
    required this.productModel,
  });
  final Size screenSize;
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: screenSize.height * .04,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            BlocBuilder<FavouriteProductCubit, FavouriteProductState>(
              builder: (context, state) {
                final isFavourite =
                    state is AddFavouriteProductSuccess ||
                    state is GetFavouriteProductByIdSuccess;

                return Container(
                  decoration: BoxDecoration(
                    color: isFavourite
                        ? Colors.grey.shade100
                        : Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(4),
                    onPressed: () {
                      if (isFavourite) {
                        context
                            .read<FavouriteProductCubit>()
                            .deleteFavoriteProduct(productModel: productModel);
                      } else {
                        context
                            .read<FavouriteProductCubit>()
                            .addFavoriteProduct(productModel: productModel);
                      }
                    },
                    icon: Icon(
                      isFavourite
                          ? Icons.favorite_outlined
                          : Icons.favorite_border_outlined,
                      color: isFavourite ? Colors.red.shade500 : Colors.black,
                      size: 20,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
