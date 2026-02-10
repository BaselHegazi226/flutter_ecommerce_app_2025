import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../view_model/search_result_cubit/search_result_cubit.dart';

class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark
        ? Theme.of(context).primaryColor
        : Colors.grey.shade700;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 44,
        child: SearchBar(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 14),
          ),
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).scaffoldBackgroundColor.withAlpha(32),
          ),
          surfaceTintColor: WidgetStatePropertyAll(
            Theme.of(context).scaffoldBackgroundColor.withAlpha(32),
          ),
          side: WidgetStatePropertyAll(BorderSide(color: color)),

          shadowColor: const WidgetStatePropertyAll(Colors.transparent),

          hintText: S.of(context).navSearch,

          textStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 14, height: 1.2, color: color),
          ),

          leading: Icon(Icons.search_outlined, size: 18, color: color),

          onSubmitted: (String? category) {
            context.read<SearchResultCubit>().getSearchResultByCategory(
              category: category?.trim() ?? '',
            );
          },
        ),
      ),
    );
  }
}
