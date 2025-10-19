import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/data/model/category_model.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/category_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:go_router/go_router.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      value: AppGet().getIt.get<ProductCubit>()
        ..getProductsByCategory(category: categoryModel.name),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(categoryModel.name),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            leading: IconWithCircleStyle(
              widget: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
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
