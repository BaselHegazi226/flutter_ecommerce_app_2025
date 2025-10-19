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

cartViewItemShimmerList(Size screenSize) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(16),
    itemCount: 5, // عدد العناصر الوهمية
    separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemBuilder: (context, index) {
      return cartViewItemShimmerItem(screenSize);
    },
  );
}
