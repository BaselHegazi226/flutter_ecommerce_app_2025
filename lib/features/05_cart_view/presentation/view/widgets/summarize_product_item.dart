import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

class SummarizeProductOrderItem extends StatelessWidget {
  const SummarizeProductOrderItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.count,
  });
  final String imageUrl, title;
  final int count;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade500.withAlpha(32)
                : Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            errorWidget: (error, url, x) {
              return const Icon(Icons.image);
            },
            imageUrl: imageUrl,
          ),
        ),
        CustomText(
          text: title.split(" ").take(2).join(" "),
          fontSize: 16,
          alignment: Alignment.centerLeft,
        ),
        CustomText(
          text: '\$ $price',
          fontSize: 16,
          alignment: Alignment.centerLeft,
          color: kPrimaryColor,
        ),
        CustomText(
          text: '$count x',
          fontSize: 14,
          alignment: Alignment.centerLeft,
          color: kGreyColor,
        ),
      ],
    );
  }
}
