import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:shimmer/shimmer.dart';

Shimmer homeProductShimmerItem(Size screenSize) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
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
  return SizedBox(
    height: screenSize.height * .4,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: 6, // 🔹 كفاية 6 لعناصر shimmer عشان الأداء
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder: (_, __) => homeProductShimmerItem(screenSize),
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
