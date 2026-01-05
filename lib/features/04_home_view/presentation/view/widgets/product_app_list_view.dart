import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/custom_sliver_grid_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/not_item_found.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../../core/utilities/custom_sliver_grid_list_view.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../view_model/product_cubit/product_cubit.dart';

class ProductAppListView extends StatelessWidget {
  const ProductAppListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomGridLayout(
      mobileWidget: ProductAppListViewMobile(),
      tabletWidget: ProductAppListViewTablet(),
    );
  }
}

class ProductAppListViewMobile extends StatelessWidget {
  const ProductAppListViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is GetProductByCategorySuccess) {
          final products = state.products;
          if (products.isEmpty) {
            return SliverToBoxAdapter(
              child: NoItemFoundByIcon(
                itemTitle: S.of(context).home_no_products_now,
                iconData: Icons.inventory_2_outlined,
              ),
            );
          }
          return CustomSliverGridListView(items: products);
        } else if (state is GetProductFailure) {
          return SliverToBoxAdapter(
            child: CustomText(
              text: '${state.errorMessage} and we will repair it soon!',
              fontSize: 18,
              alignment: Alignment.center,
            ),
          );
        }
        return customSliverGridListShimmer(size: screenSize, itemsInLine: 2);
      },
    );
  }
}

class ProductAppListViewTablet extends StatelessWidget {
  const ProductAppListViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is GetProductByCategorySuccess) {
          final products = state.products;
          if (products.isEmpty) {
            return SliverToBoxAdapter(
              child: NoItemFoundByIcon(
                itemTitle: S.of(context).home_no_products_now,
                iconData: Icons.inventory_2_outlined,
              ),
            );
          }
          return CustomSliverGridListView(
            items: products,
            itemsInLine: 3,
            crossAxisSpacing: 28,
            childAspectRatio: .65,
          );
        } else if (state is GetProductByCategoryFailure) {
          return SliverToBoxAdapter(
            child: CustomText(
              text: state.errorMessage,
              fontSize: 18,
              alignment: Alignment.center,
            ),
          );
        }
        return customSliverGridListShimmer(
          size: screenSize,
          itemsInLine: 3,
          crossAxisSpacing: 28,
          childAspectRatio: .65,
        );
      },
    );
  }
}
