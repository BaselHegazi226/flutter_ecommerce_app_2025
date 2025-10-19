import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/home_product_shimmer.dart';

import '../../../../../core/utilities/custom_text.dart';

class BestSellingProductItem extends StatelessWidget {
  const BestSellingProductItem({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenSize.width * .45,
            height: screenSize.height * .3,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return homeProductImageShimmer(screenSize);
                },
                errorWidget: (context, url, error) {
                  return Icon(Icons.image_not_supported_outlined);
                },
              ),
            ),
          ),
          SizedBox(height: screenSize.height * .015),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3,
            children: [
              CustomText(
                text: title.split(" ").take(3).join(" ").length > 20
                    ? title.split(" ").take(2).join(" ")
                    : title.split(" ").take(3).join(" "),
                fontSize: 16,
                alignment: Alignment.topLeft,
              ),
              CustomText(
                text: description.split(" ").take(3).join(" ").length > 20
                    ? description.split(" ").take(2).join(" ")
                    : description.split(" ").take(3).join(" "),
                fontSize: 12,
                color: Color(0xff929292),
                alignment: Alignment.topLeft,
              ),
              CustomText(
                text: '\$ $price',
                fontSize: 16,
                color: kPrimaryColor,
                alignment: Alignment.topLeft,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
