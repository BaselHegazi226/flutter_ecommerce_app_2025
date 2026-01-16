import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/data/model/favourite_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/presentation/view/widgets/product_details_price_button_section.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/presentation/view/widgets/product_details_view_body.dart';

import '../../../../core/cache/favourite_cache.dart';
import '../../../07_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import '../view_model/favourite_product_cubit/favourite_product_cubit.dart';
import '../view_model/product_cubit/product_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductCubit()..getProductById(productId: productId),
        ),
        BlocProvider(create: (context) => AppGet().getIt<CartBloc>()),
        BlocProvider(
          create: (context) => FavouriteProductCubit(
            favouriteCache: AppGet().getIt<FavouriteCacheImplement>(),
          )..getFavouriteProductById(productId: productId),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is GetProductByIdSuccess) {
              final productModel = state.productModel;
              final favouriteModel = FavouriteModel(
                id: productModel.id,
                title: productModel.title,
                desc: productModel.description,
                image: productModel.images[0],
                price: productModel.price,
                addAt: DateTime.now(),
              );
              return ProductDetailsViewBody(
                productModel: productModel,
                favouriteModel: favouriteModel,
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
              return CustomCircleIndicator(
                color: Theme.of(context).primaryColor,
              );
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is GetProductByIdSuccess) {
              final productModel = state.productModel;
              return ProductDetailsPriceButtonSection(
                productModel: productModel,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
