import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/07_search_view/presentation/view/widgets/search_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/07_search_view/presentation/view_model/search_result_cubit/search_result_cubit.dart';

import '../../../../core/utilities/custom_text.dart';
import '../../../../generated/l10n.dart';

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
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            title: CustomText(text: S.of(context).navSearch, fontSize: 20),
            centerTitle: true,
          ),
          body: const SearchViewBody(),
        ),
      ),
    );
  }
}
