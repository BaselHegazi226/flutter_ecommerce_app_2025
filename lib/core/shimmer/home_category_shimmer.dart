import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer homeCategoryShimmerItem(Size screenSize) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // صورة دائرية
        Container(
          height: screenSize.height * .13, // أصغر من .18 بتاعت الـ ListView
          width: screenSize.width * .2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withAlpha(32),
          ),
        ),
        const SizedBox(height: 8),
        // مستطيل كأنه اسم تحت الصورة
        Container(
          height: 12,
          width: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    ),
  );
}

Widget homeViewCategoriesShimmerList(Size screenSize) {
  return SizedBox(
    height: screenSize.height * .18,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      separatorBuilder: (context, index) {
        return const SizedBox(width: 20);
      },
      itemBuilder: (context, index) {
        final Size screenSize = MediaQuery.sizeOf(context);
        return homeCategoryShimmerItem(screenSize);
      },
    ),
  );
}
