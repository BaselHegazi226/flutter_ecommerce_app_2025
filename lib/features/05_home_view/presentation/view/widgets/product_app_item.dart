import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../../core/shimmer/category_shimmer.dart';
import '../../../../../core/utilities/custom_text.dart';

class ProductAppItem extends StatelessWidget {
  const ProductAppItem({
    super.key,
    required this.screenSize,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.onTap,
  });

  final Size screenSize;
  final String image, title, description;
  final double price;
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
                  return categoryImageShimmer();
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
              CustomText(
                text: '${priceShowed(price)} ${S.of(context).EP}',
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
