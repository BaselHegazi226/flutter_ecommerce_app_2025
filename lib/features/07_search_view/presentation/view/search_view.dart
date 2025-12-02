import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/search_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/features/07_search_view/presentation/view_model/search_result_cubit/search_result_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/routes.dart';
import '../../../../core/utilities/custom_text.dart';
import '../../../../generated/l10n.dart';
import '../../../04_home_view/presentation/view/widgets/category_view_product_item.dart';
import 'widgets/search_bar_section.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) =>
          SearchResultCubit()..getSearchResultByCategory(category: ''),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            title: CustomText(text: S.of(context).Search, fontSize: 20),
            centerTitle: true,
          ),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: size.height * .03)),
              const SliverToBoxAdapter(child: SearchBarSection()),
              SliverToBoxAdapter(child: SizedBox(height: size.height * .02)),
              const SearchViewBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocBuilder<SearchResultCubit, SearchResultState>(
      builder: (context, state) {
        if (state is GetSearchResultSuccess) {
          final products = state.products;

          if (products.isEmpty) {
            return const SliverToBoxAdapter(
              child: Align(
                alignment: AlignmentGeometry.center,
                child: CustomText(
                  text: 'No products are available!',
                  fontSize: 20,
                  alignment: Alignment.center,
                ),
              ),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 12,
                childAspectRatio: 0.55,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = products[index];
                return CategoryViewProductItem(
                  screenSize: size,
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
              }, childCount: products.length),
            ),
          );
        } else if (state is GetSearchResultFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: CustomText(
                text: '${state.errorMessage} and we will repair it soon!',
                fontSize: 18,
                alignment: Alignment.center,
              ),
            ),
          );
        }

        return searchViewProductShimmerGrid(size);
      },
    );
  }
}
