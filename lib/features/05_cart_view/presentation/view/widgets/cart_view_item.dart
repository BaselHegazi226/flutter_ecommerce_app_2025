import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/cart_view_count_section.dart';

class CartViewItem extends StatelessWidget {
  const CartViewItem({
    super.key,

    required this.imageUrl,
    required this.title,
    required this.productId,
    required this.count,
    required this.price,
  });

  final String imageUrl, title;
  final int productId, count;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade500.withAlpha(32)
                  : Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: AspectRatio(
              aspectRatio: .75,
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                errorWidget: (error, url, x) {
                  return const Icon(Icons.image);
                },
                imageUrl: imageUrl,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: title.split(" ").take(4).join(" "),
                fontSize: 20,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: '\$ $price',
                fontSize: 20,
                color: kPrimaryColor,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 16),
              CartViewCountSection(count: count, id: productId),
            ],
          ),
        ),
      ],
    );
  }
}
