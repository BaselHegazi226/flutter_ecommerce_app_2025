import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/06_search_view/presentation/view/widgets/search_bar_section.dart';
import 'package:flutter_e_commerce_app_2025/features/06_search_view/presentation/view/widgets/search_view_grid_list.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: size.height * .03)),
        const SliverToBoxAdapter(child: SearchBarSection()),
        SliverToBoxAdapter(child: SizedBox(height: size.height * .02)),
        const SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SearchViewGridList(),
        ),
        SliverToBoxAdapter(child: SizedBox(height: size.height * .025)),
      ],
    );
  }
}
