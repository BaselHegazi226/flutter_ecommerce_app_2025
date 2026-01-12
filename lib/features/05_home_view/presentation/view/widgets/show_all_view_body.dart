import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/custom_sliver_grid_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_sliver_grid_list_view.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../../core/utilities/custom_text.dart';
import '../../view_model/show_all_cubit/show_all_cubit.dart';

class ShowAllViewBody extends StatelessWidget {
  const ShowAllViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomLayout(
      mobileWidget: ShowAllViewBodyMobile(),
      tabletWidget: ShowAllViewBodyTablet(),
    );
  }
}

class ShowAllViewBodyMobile extends StatelessWidget {
  const ShowAllViewBodyMobile({super.key});

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
          return CustomGridListView(items: products);
        } else if (state is ShowAllFailure) {
          return Center(
            child: CustomText(
              text: state.errorMessage,
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

class ShowAllViewBodyTablet extends StatelessWidget {
  const ShowAllViewBodyTablet({super.key});

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
          return CustomGridListView(
            items: products,
            childAspectRatio: .65,
            itemsInLine: 3,
            crossAxisSpacing: 28,
          );
        } else if (state is ShowAllFailure) {
          return Center(
            child: CustomText(
              text: state.errorMessage,
              fontSize: 18,
              alignment: Alignment.center,
            ),
          );
        }
        return customGridViewListShimmer(
          size: screenSize,
          childAspectRatio: .65,
          itemsInLine: 3,
          crossAxisSpacing: 28,
        );
      },
    );
  }
}
