import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/06_search_view/presentation/view/widgets/search_view_body.dart';

import '../../../../generated/l10n.dart';
import '../view_model/search_result_cubit/search_result_cubit.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchResultCubit()
            ..getSearchResultByCategory(category: 'smartPhones'),
      child: SafeArea(
        child: Scaffold(
          appBar: customTabsAppbar(context, S.of(context).navSearch),
          body: const SearchViewBody(),
        ),
      ),
    );
  }
}
