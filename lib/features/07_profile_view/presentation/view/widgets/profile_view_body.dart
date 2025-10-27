import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/07_profile_view/presentation/view/widgets/profile_view_header.dart';
import 'package:flutter_e_commerce_app_2025/features/07_profile_view/presentation/view/widgets/profile_view_item_list.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: ProfileViewHeader()),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(child: ProfileViewItemList()),
        ],
      ),
    );
  }
}
