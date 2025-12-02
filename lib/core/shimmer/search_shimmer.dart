import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

searchViewProductShimmerItem(Size screenSize) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade500.withAlpha(32),
    highlightColor: Colors.grey.shade400.withAlpha(32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // صورة المنتج
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 16,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 4),
            Container(
              height: 12,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 4),
            Container(height: 16, width: 60, color: Colors.grey.shade300),
          ],
        ),
      ],
    ),
  );
}

SliverPadding searchViewProductShimmerGrid(Size screenSize) {
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
        (context, index) => searchViewProductShimmerItem(screenSize),
        childCount: 6, // عدد العناصر الوهمية
      ),
    ),
  );
}
