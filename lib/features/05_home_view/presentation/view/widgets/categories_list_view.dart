import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/home_category_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../../data/model/category_model.dart';
import '../../view_model/category_cubit/category_cubit.dart';
import '../../view_model/product_cubit/product_cubit.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  ValueNotifier<int> selectedItem = ValueNotifier(-1);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is GetCategorySuccess) {
          final categories = state.categories;
          debugPrint('categories = ${categories[0].toJson()}');
          return SizedBox(
            height: 44,
            child: ValueListenableBuilder(
              valueListenable: selectedItem,
              builder: (context, value, child) {
                return buildListView(categories, screenSize);
              },
            ),
          );
        } else if (state is GetCategoryFailure) {
          debugPrint('error = ${state.errorMessage}');
          return Center(
            child: Text(S.of(context).home_not_categories_available_now),
          );
        } else {
          return homeViewCategoriesShimmerList(screenSize);
        }
      },
    );
  }

  ListView buildListView(List<CategoryModel> categories, Size screenSize) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: categories.length,
      separatorBuilder: (context, index) {
        return const SizedBox(width: 16);
      },
      itemBuilder: (context, index) {
        return _categoryItem(
          name: categories[index].name,
          slug: S.of(context).categoryFunction(categories[index].slug),
          onTap: () {
            selectedItem.value = index;
            context.read<ProductCubit>().getProductsByCategory(
              category: categories[index].slug,
            );
            debugPrint('name = ${categories[index].slug}');
          },
          textColor: selectedItem.value == index
              ? Colors.grey.shade50
              : Colors.grey,
          backgroundColor: selectedItem.value == index
              ? Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade500
                    : kPrimaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderColor: selectedItem.value == index
              ? Colors.transparent
              : Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade50
              : Colors.grey,
        );
      },
    );
  }

  _categoryItem({
    required String name,
    required String slug,

    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(32)),
      child: AnimatedContainer(
        width: 156,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        ),
        child: CustomText(
          text: slug,
          fontSize: 14,
          alignment: Alignment.center,
          color: textColor,
        ),
      ),
    );
  }
}
