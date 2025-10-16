import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/favourite_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/product_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/product_details_price_button_section.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/product_details_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/favourite_product_cubit/favourite_product_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: AppGet().getIt<CartBloc>()),
        BlocProvider(
          create: (context) => FavouriteProductCubit(
            favouriteCache: AppGet().getIt<FavouriteCacheImplement>(),
          )..getFavouriteProductById(productModel: productModel),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kScaffoldColor,
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
      ),
    );
  }
}
