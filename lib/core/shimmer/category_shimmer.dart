import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../helper/const.dart';

categoryViewProductShimmerItem() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade500.withAlpha(32),
    highlightColor: Colors.grey.shade400.withAlpha(32),
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
    itemCount: 6, // عدد العناصر الوهمية
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 12,
      childAspectRatio: 0.55,
    ),
    itemBuilder: (context, index) {
      return categoryViewProductShimmerItem();
    },
  );
}

Widget categoryImageShimmer() {
  return const DecoratedBox(
    decoration: BoxDecoration(
      color: kGreyColor,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
}
