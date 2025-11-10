import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/repo/home_view_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/product_details_price_button_section.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/product_details_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';

import '../../../../core/cache/favourite_cache.dart';
import '../view_model/favourite_product_cubit/favourite_product_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductCubit(homeViewRepo: AppGet().getIt<HomeViewRepoImpl>())
                ..getProductById(productId: productId),
        ),
        BlocProvider.value(value: AppGet().getIt<CartBloc>()),
        BlocProvider(
          create: (context) => FavouriteProductCubit(
            favouriteCache: AppGet().getIt<FavouriteCacheImplement>(),
          )..getFavouriteProductById(productId: productId),
        ),
      ],
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is GetProductByIdSuccess) {
            final productModel = state.productModel;
            return SafeArea(
              child: Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: ProductDetailsViewBody(productModel: productModel),
                    ),
                  ],
                ),
                bottomNavigationBar: ProductDetailsPriceButtonSection(
                  productModel: productModel,
                ),
              ),
            );
          } else if (state is GetProductByIdFailure) {
            return Center(
              child: CustomText(
                text: state.errorMessage,
                fontSize: 20,
                alignment: Alignment.center,
              ),
            );
          } else {
            return const CustomCircleIndicator(color: kPrimaryColor);
          }
        },
      ),
    );
  }
}
