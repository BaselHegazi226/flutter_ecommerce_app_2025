import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/categories_header.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/categories_list_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/home_view_profile_section.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/product_app_header.dart';

import 'product_app_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: screenSize.height * .025)),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              const HomeViewProfileSection(),
              SizedBox(height: screenSize.height * .02),
              const CategoriesHeader(),
              SizedBox(height: screenSize.height * .02),
              const CategoriesListView(),
              SizedBox(height: screenSize.height * .03),
              const ProductAppHeader(),
            ]),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: ProductAppListView(),
        ),
      ],
    );
  }
}
