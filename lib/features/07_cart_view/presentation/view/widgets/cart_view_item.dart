import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import 'cart_delete_cart_product_section.dart';
import 'cart_view_count_section.dart';

class CartViewItemMobile extends StatelessWidget {
  const CartViewItemMobile({
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
    final screenSize = MediaQuery.sizeOf(context);
    return SizedBox(
      height: 150,
      child: Row(
        spacing: screenSize.width * .03,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(8),
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
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: title.split(" ").take(2).join(" ").length > 15
                              ? title.split(" ").take(1).join(" ")
                              : title.split(" ").take(2).join(" "),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        DeleteCartProductSection(productId: productId),
                      ],
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: '${priceShowed(price)} ${S.of(context).EP}',
                      fontSize: 20,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CartViewCountSection(count: count, id: productId),
                    ),
                    SizedBox(width: screenSize.width * .02),
                    Expanded(
                      flex: 1,
                      child: CartView5CountSection(count: count, id: productId),
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
}

class CartViewItemTablet extends StatelessWidget {
  const CartViewItemTablet({
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
    final screenSize = MediaQuery.sizeOf(context);
    return Row(
      spacing: screenSize.width * .03,
      crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    errorWidget: (error, url, x) {
                      return const Icon(Icons.image_not_supported);
                    },
                    imageUrl: imageUrl,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: title.split(" ").take(2).join(" ").length > 15
                            ? title.split(" ").take(1).join(" ")
                            : title.split(" ").take(2).join(" "),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      DeleteCartProductSection(productId: productId),
                    ],
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: '${priceShowed(price)} ${S.of(context).EP}',
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CartViewCountSection(count: count, id: productId),
                  ),
                  SizedBox(width: screenSize.width * .02),
                  Expanded(
                    flex: 1,
                    child: CartView5CountSection(count: count, id: productId),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
