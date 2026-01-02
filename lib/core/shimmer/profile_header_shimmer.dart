import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget profileHeaderShimmer(Size size) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // صورة البروفايل (دائرة)
        Container(
          height: size.height * .1,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),

        // الاسم والإيميل
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // اسم المستخدم
            Container(
              height: 20,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8),
            // البريد الإلكتروني
            Container(
              height: 14,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
