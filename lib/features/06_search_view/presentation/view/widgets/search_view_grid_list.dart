import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/custom_sliver_grid_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../../core/utilities/custom_sliver_grid_list_view.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../view_model/search_result_cubit/search_result_cubit.dart';

class SearchViewGridList extends StatelessWidget {
  const SearchViewGridList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocBuilder<SearchResultCubit, SearchResultState>(
      builder: (context, state) {
        if (state is GetSearchResultSuccess) {
          final products = state.products;

          if (products.isEmpty) {
            return SliverToBoxAdapter(
              child: Align(
                alignment: AlignmentGeometry.center,
                child: CustomText(
                  text: S.of(context).homeNoProduct,
                  fontSize: 20,
                  alignment: Alignment.center,
                ),
              ),
            );
          }
          return CustomGridLayout(
            mobileWidget: CustomSliverGridListView(items: products),
            tabletWidget: CustomSliverGridListView(
              items: products,
              itemsInLine: 3,
            ),
          );
        } else if (state is GetSearchResultFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: CustomText(
                text: state.errorMessage,
                fontSize: 18,
                alignment: Alignment.center,
              ),
            ),
          );
        }

        return CustomGridLayout(
          mobileWidget: customSliverGridListShimmer(size: size),
          tabletWidget: customSliverGridListShimmer(size: size, itemsInLine: 3),
        );
      },
    );
  }
}
