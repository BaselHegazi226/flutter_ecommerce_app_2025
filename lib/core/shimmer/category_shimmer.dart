import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../helper/const.dart';

categoryViewProductShimmerItem() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // صورة
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 16,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            Container(
              height: 12,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            Container(height: 16, width: 60, color: Colors.grey.shade300),
          ],
        ),
      ],
    ),
  );
}

categoryViewProductShimmerList() {
  return GridView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: 6, // عدد العناصر الوهمية
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 12,
      childAspectRatio: 0.65,
    ),
    itemBuilder: (context, index) {
      return categoryViewProductShimmerItem();
    },
  );
}

Widget categoryImageShimmer(Size screenSize) {
  return Container(
    width: screenSize.width * .4,
    height: screenSize.height * .25,
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: kGreyColor,
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );
}
