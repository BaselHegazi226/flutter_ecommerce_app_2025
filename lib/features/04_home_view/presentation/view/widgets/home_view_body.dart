import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/best_selling_header.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/best_selling_list_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/categories_header.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/categories_list_view.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view/widgets/search_bar_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: screenSize.height * .04)),
        const SliverToBoxAdapter(child: SearchBarSection()),
        SliverToBoxAdapter(child: SizedBox(height: screenSize.height * .02)),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              const CategoriesHeader(),
              SizedBox(height: screenSize.height * .02),
              const CategoriesListView(),
              SizedBox(height: screenSize.height * .03),
              const BestSellingHeader(),
              SizedBox(height: screenSize.height * .03),
              const BestSellingListView(),
            ]),
          ),
        ),
      ],
    );
  }
}
