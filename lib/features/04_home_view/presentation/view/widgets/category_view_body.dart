import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/category_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/category_view_product_item.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:go_router/go_router.dart';

class CategoryViewBody extends StatelessWidget {
  const CategoryViewBody({super.key, required this.screenSize});

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is GetProductByCategorySuccess) {
          final products = state.products;
          debugPrint('list = $products');
          if (products.isEmpty) {
            return const Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: CustomText(
                  text: 'No products are available!',
                  fontSize: 20,
                  alignment: Alignment.center,
                ),
              ),
            );
          }
          return GridView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // خلي اتنين جنب بعض
              crossAxisSpacing: 8, // مسافة أفقية بين العناصر
              mainAxisSpacing: 12, // مسافة رأسية بين العناصر
              childAspectRatio: 0.55, // النسبة بين العرض والارتفاع
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return CategoryViewProductItem(
                screenSize: screenSize,
                image: product.images[0],
                title: product.title,
                description: product.description,
                price: product.price.toString(),
                onTap: () {
                  GoRouter.of(
                    context,
                  ).push(Routes.productDetailsView, extra: product.id);
                },
              );
            },
          );
        } else if (state is GetProductByCategoryFailure) {
          return Center(
            child: CustomText(
              text: '${state.errorMessage} and we will repair it soon!',
              fontSize: 18,
              alignment: Alignment.center,
            ),
          );
        } else {
          return categoryViewProductShimmerList();
        }
      },
    );
  }
}
