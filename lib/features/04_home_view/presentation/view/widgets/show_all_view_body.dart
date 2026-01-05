import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/custom_sliver_grid_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_sliver_grid_list_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/show_all_cubit/show_all_cubit.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/routes.dart';
import '../../../../../core/utilities/custom_text.dart';

class ShowAllViewBody extends StatelessWidget {
  const ShowAllViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<ShowAllCubit, ShowAllState>(
      builder: (context, state) {
        if (state is ShowAllSuccess) {
          final products = state.products;
          if (products.isEmpty) {
            return Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: CustomText(
                  text: S.of(context).homeNoProduct,
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
              return CustomSliverGridItem(
                screenSize: screenSize,
                image: product.images[0],
                title: product.title,
                description: product.description,
                price: product.price,
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
        }
        return customGridViewListShimmer(size: screenSize);
      },
    );
  }
}
