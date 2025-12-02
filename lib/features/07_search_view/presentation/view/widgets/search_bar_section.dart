import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/07_search_view/presentation/view_model/search_result_cubit/search_result_cubit.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SearchBar(
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).scaffoldBackgroundColor.withAlpha(32),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).primaryColor
                : Colors.grey.shade500,
          ),
        ),
        shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        hintText: S.of(context).Search,
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).primaryColor
                : Colors.grey.shade500,
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20),
        ),
        leading: Icon(
          Icons.search_outlined,
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).primaryColor
              : Colors.grey.shade500,
        ),
        onSubmitted: (String? category) {
          if (category == null || category.isEmpty) {
            context.read<SearchResultCubit>().getSearchResultByCategory(
              category: '',
            );
          } else {
            context.read<SearchResultCubit>().getSearchResultByCategory(
              category: category,
            );
          }
        },
      ),
    );
  }
}
