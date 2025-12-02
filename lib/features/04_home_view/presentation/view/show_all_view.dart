import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/category_view_product_item.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/show_all_cubit/show_all_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/routes.dart';
import '../../../../core/shimmer/category_shimmer.dart';
import '../../../../core/utilities/custom_app_bar.dart';
import '../../../../core/utilities/custom_text.dart';
import '../../../../generated/l10n.dart';

class ShowAllView extends StatelessWidget {
  const ShowAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowAllCubit()..showAllProduct(),
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(context, S.of(context).AllProducts, () {
            GoRouter.of(context).pop();
          }),
          body: const Padding(
            padding: EdgeInsets.all(16),
            child: ShowAllViewBody(),
          ),
        ),
      ),
    );
  }
}

class ShowAllViewBody extends StatelessWidget {
  const ShowAllViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<ShowAllCubit, ShowAllState>(
      builder: (context, state) {
        if (state is ShowAllSuccess) {
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // خلي اتنين جنب بعض
              crossAxisSpacing: 16, // مسافة أفقية بين العناصر
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
        } else if (state is ShowAllFailure) {
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
