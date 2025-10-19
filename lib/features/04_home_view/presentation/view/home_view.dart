import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/home_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/product_cubit/product_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AppGet().getIt.get<CategoryCubit>()..getCategories(),
        ),
        BlocProvider.value(
          value: AppGet().getIt.get<ProductCubit>()..getBestSellingProducts(),
        ),
      ],
      child: const SafeArea(
        child: Scaffold(backgroundColor: kScaffoldColor, body: HomeViewBody()),
      ),
    );
  }
}
