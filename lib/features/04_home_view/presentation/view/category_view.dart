import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/category_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/repo/home_view_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/category_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:go_router/go_router.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) =>
          ProductCubit(homeViewRepo: AppGet().getIt<HomeViewRepoImpl>())
            ..getProductsByCategory(category: categoryModel.name),
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(context, categoryModel.name, () {
            GoRouter.of(context).pop();
          }),
          body: CategoryViewBody(screenSize: screenSize),
        ),
      ),
    );
  }
}

// int categoryNumber({required String categoryName}) {
//   switch (categoryName) {
//     case 'Gaming':
//       return 1;
//     case 'Men':
//       return 2;
//     case 'Gadest':
//       return 3;
//     case 'Women':
//       return 4;
//     case 'Device':
//       return 5;
//     default:
//       return 1;
//   }
// }
