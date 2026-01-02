import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/custom_sliver_grid_shimmer.dart';
import 'package:shimmer/shimmer.dart';

Shimmer homeProductShimmerItem(Size screenSize) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade500.withAlpha(32),
    highlightColor: Colors.grey.shade400.withAlpha(32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenSize.width * .4,
          height: screenSize.height * .3,
          decoration: const BoxDecoration(
            color: kGreyColor,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        SizedBox(height: screenSize.height * .015),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Container(
              height: 10,
              width: screenSize.width * .35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              height: 10,
              width: screenSize.width * .3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              height: 10,
              width: screenSize.width * .25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// 🔹 قائمة كاملة (Shimmer List)
Widget homeProductShimmerList(Size screenSize) {
  return SliverPadding(
    padding: const EdgeInsets.all(16),
    sliver: SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: customSliverGridShimmerItem(screenSize),
        ),
        childCount: 6, // عدد العناصر الوهمية
      ),
    ),
  );
}

Widget homeProductImageShimmer(Size screenSize) {
  return Container(
    width: screenSize.width * .4,
    height: screenSize.height * .25,
    decoration: BoxDecoration(
      color: kGreyColor.withAlpha(50),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    ),
  );
}
