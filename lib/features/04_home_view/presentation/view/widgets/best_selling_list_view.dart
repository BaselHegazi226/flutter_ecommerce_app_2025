import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/home_product_shimmer.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/routes.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../view_model/product_cubit/product_cubit.dart';
import 'best_selling_product_item.dart';

class BestSellingListView extends StatelessWidget {
  const BestSellingListView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is GetProductSuccess) {
          final products = state.products;
          return SizedBox(
            height: screenSize.height * .4,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(width: 16);
              },
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return BestSellingProductItem(
                  screenSize: screenSize,
                  image: products[index].images[0],
                  title: products[index].title,
                  description: products[index].description,
                  price: products[index].price.toString(),
                  onTap: () {
                    GoRouter.of(context).push(
                      Routes.productDetailsView,
                      extra: products[index].id,
                    );
                  },
                );
              },
            ),
          );
        } else if (state is GetProductFailure) {
          return Center(
            child: CustomText(
              text: state.errorMessage,
              fontSize: 18,
              alignment: Alignment.center,
            ),
          );
        } else {
          return homeProductShimmerList(screenSize);
        }
      },
    );
  }
}
