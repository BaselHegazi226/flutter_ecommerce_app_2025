import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/shimmer/category_shimmer.dart';
import '../../../../../core/utilities/custom_text.dart';

class CategoryViewProductItem extends StatelessWidget {
  const CategoryViewProductItem({
    super.key,
    required this.screenSize,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.onTap,
  });
  final Size screenSize;
  final String image, title, description, price;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade500.withAlpha(32),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.contain, // مهم عشان تملى المساحة كويس
                errorWidget: (error, url, child) {
                  return const Icon(Icons.image);
                },
                placeholder: (context, url) {
                  return categoryImageShimmer(screenSize);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title.split(" ").take(2).join(" "),
                fontSize: 16,
              ),
              CustomText(
                text: description.split(" ").take(3).join(" ").length > 20
                    ? description.split(" ").take(2).join(" ")
                    : description.split(" ").take(3).join(" "),
                fontSize: 12,
                color: const Color(0xff929292),
              ),
              CustomText(text: '\$$price', fontSize: 16, color: kPrimaryColor),
            ],
          ),
        ],
      ),
    );
  }
}
