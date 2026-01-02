import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

customSliverGridShimmerItem(Size screenSize) {
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

SliverGrid customSliverGridListShimmer({
  required Size size,
  int itemsInLine = 2,
}) {
  return SliverGrid(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: itemsInLine,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.55,
    ),
    delegate: SliverChildBuilderDelegate(
      (context, index) => customSliverGridShimmerItem(size),
      childCount: itemsInLine > 2 ? 16 : 8, // عدد العناصر الوهمية
    ),
  );
}

GridView customGridViewListShimmer({required Size size, int itemsInLine = 2}) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: itemsInLine,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.55,
    ),
    itemCount: itemsInLine > 2 ? 16 : 8,
    itemBuilder: (context, index) {
      return customSliverGridShimmerItem(size);
    },
  );
}
