import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer homeCategoryShimmerItem(Size screenSize) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: 40,
      width: 156,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
    ),
  );
}

Widget homeViewCategoriesShimmerList(Size screenSize) {
  return SizedBox(
    height: 40,
    width: 156,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 16, width: 20),
      itemBuilder: (context, index) {
        final Size screenSize = MediaQuery.sizeOf(context);
        return homeCategoryShimmerItem(screenSize);
      },
    ),
  );
}
