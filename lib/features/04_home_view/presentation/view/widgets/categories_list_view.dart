import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/home_category_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_by_category_name.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:go_router/go_router.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    debugPrint('perperrrrrrrr = ${140 / screenSize.height}');
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is GetCategorySuccess) {
          final categories = state.categories;
          return SizedBox(
            height: screenSize.height * .18,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 16);
              },
              itemBuilder: (context, index) {
                return CategoryItem(
                  name: categories[index].name,
                  slug: categories[index].slug,
                  onTap: () {
                    context.push(
                      '${Routes.homeView}${Routes.categoryView}',
                      extra: categories[index],
                    );
                  },
                  screenSize: screenSize,
                );
              },
            ),
          );
        } else if (state is GetCategoryFailure) {
          debugPrint('error = ${state.errorMessage}');
          return const Center(child: Text('Not Categories available now!'));
        } else {
          return homeViewCategoriesShimmerList(screenSize);
        }
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.name,
    required this.slug,
    required this.screenSize,
    required this.onTap,
    this.textColor = Colors.black,
  });

  final String name;
  final String slug;
  final Size screenSize;
  final VoidCallback onTap;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey.withAlpha(10),
      borderRadius: const BorderRadius.all(Radius.circular(32)),
      child: CategoryIcon.fromSlug(context, slug),
    );
  }
}
