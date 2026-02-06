import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/home_category_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../../core/utilities/custom_text.dart';
import '../../../data/model/category_model.dart';
import '../../view_model/category_cubit/category_cubit.dart';
import '../../view_model/product_cubit/product_cubit.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView>
    with AutomaticKeepAliveClientMixin {
  final ValueNotifier<int> selectedItem = ValueNotifier(-1);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size screenSize = MediaQuery.sizeOf(context);

    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is GetCategorySuccess) {
          final categories = state.categories;

          return SizedBox(
            height: 58,
            child: ValueListenableBuilder<int>(
              valueListenable: selectedItem,
              builder: (context, value, _) {
                return _buildListView(categories);
              },
            ),
          );
        } else if (state is GetCategoryFailure) {
          return Center(
            child: Text(S.of(context).home_not_categories_available_now),
          );
        } else {
          return homeViewCategoriesShimmerList(screenSize);
        }
      },
    );
  }

  ListView _buildListView(List<CategoryModel> categories) {
    return ListView.separated(
      key: const PageStorageKey("categories"),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder: (context, index) {
        final bool isSelected = selectedItem.value == index;
        final colors = _resolveCategoryColors(
          context: context,
          isSelected: isSelected,
        );

        return _CategoryItem(
          text: S.of(context).categoryFunction(categories[index].slug),
          isSelected: isSelected,
          isDark: Theme.of(context).brightness == Brightness.dark,
          backgroundColor: colors.background,
          textColor: colors.text,

          onTap: () {
            selectedItem.value = index;
            context.read<ProductCubit>().getProductsByCategory(
              category: categories[index].slug,
            );
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/* -------------------------------------------------------------------------- */
/*                               UI COMPONENT                                 */
/* -------------------------------------------------------------------------- */

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    required this.isSelected,
    required this.isDark,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: IntrinsicWidth(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(32),
          ),
          alignment: Alignment.center,
          child: CustomText(
            text: text,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: textColor,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                             COLOR RESOLUTION                                */
/* -------------------------------------------------------------------------- */

class _CategoryColors {
  final Color background;
  final Color text;

  const _CategoryColors({required this.background, required this.text});
}

_CategoryColors _resolveCategoryColors({
  required BuildContext context,
  required bool isSelected,
}) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  if (isSelected) {
    return _CategoryColors(
      background: isDark ? Colors.grey.shade200 : kPrimaryColor,
      text: isDark ? Colors.black54 : Colors.grey.shade100,
    );
  } else {
    return _CategoryColors(
      background: isDark
          ? Colors.grey.shade600
          : Colors.grey.shade500.withAlpha(32),
      text: isDark ? Colors.white : Colors.black54,
    );
  }
}
