import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/repo/home_view_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/home_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';

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
      child: const SafeArea(child: Scaffold(body: HomeViewBody())),
    );
  }
}
