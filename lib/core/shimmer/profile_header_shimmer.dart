import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget profileHeaderShimmer(Size size) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // صورة البروفايل (دائرة)
        Container(
          height: size.width * .2,
          width: size.width * .2,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        // الاسم والإيميل
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

Widget editProfileImageShimmer(Size size) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Stack(
      children: [
        Container(
          height: size.width * .35,
          width: size.width * .35,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          bottom: size.width * 0.025,
          right: size.width * 0.01,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: size.width * 0.055,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
