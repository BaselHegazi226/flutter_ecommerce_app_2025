import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

cartViewItemShimmerItem(Size screenSize) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // صورة المنتج
        Expanded(
          flex: 1,
          child: Container(
            height: screenSize.height * .15,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // تفاصيل المنتج
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 8),
              Container(height: 18, width: 100, color: Colors.grey.shade300),
              const SizedBox(height: 16),
              // عداد الكمية (نسخة شيمر من CartViewCountSection)
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * .02),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

cartViewItemShimmerListMobile(Size screenSize) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 5, // عدد العناصر الوهمية
    separatorBuilder: (context, index) => const SizedBox(height: 16, width: 20),
    itemBuilder: (context, index) {
      return cartViewItemShimmerItem(screenSize);
    },
  );
}

GridView cartViewItemShimmerListTablet(Size screenSize) {
  return GridView.builder(
    itemCount: 12,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 12,
      childAspectRatio: .55,
    ),
    itemBuilder: (context, index) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final shimmerColor = isDark
          ? Colors.grey.shade500.withAlpha(40)
          : Colors.grey.shade300;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image shimmer
          Container(
            height: 150,
            width: 110,
            decoration: BoxDecoration(
              color: shimmerColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          SizedBox(width: screenSize.width * .03),

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title shimmer
                Container(
                  height: 22,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: shimmerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(height: 6),

                // Price shimmer
                Container(
                  height: 22,
                  width: 120,
                  decoration: BoxDecoration(
                    color: shimmerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(height: 16),

                // Count + delete shimmer
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: shimmerColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * .02),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
