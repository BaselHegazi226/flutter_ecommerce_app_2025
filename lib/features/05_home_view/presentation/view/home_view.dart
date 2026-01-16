import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/presentation/view/widgets/home_view_body.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../08_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
import '../../data/repo/home_view_repo_impl.dart';
import '../view_model/category_cubit/category_cubit.dart';
import '../view_model/product_cubit/product_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserInfoCubit()..getUserInfo()),
        BlocProvider(
          create: (context) =>
              CategoryCubit(homeViewRepo: AppGet().getIt<HomeViewRepoImpl>())
                ..getCategories(),
        ),
        BlocProvider(
          create: (context) =>
              ProductCubit()..getProductsByCategory(category: 'SmartPhones'),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: customTabsAppbar(context, S.of(context).navHome),
        body: const HomeViewBody(),
      ),
    );
  }
}
