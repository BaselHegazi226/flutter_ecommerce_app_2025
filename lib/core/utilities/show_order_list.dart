import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../features/07_cart_view/data/model/cart_model.dart';
import '../../generated/l10n.dart';
import '../helper/const.dart';
import '../helper/extensions_of_s_localization.dart';
import 'custom_text.dart';

class ShowOrderList extends StatelessWidget {
  const ShowOrderList({
    super.key,
    required this.carts,
    this.heightOfList = 200,
  });

  final List<CartModel> carts;
  final double heightOfList;

  @override
  Widget build(BuildContext context) {
    if (carts.isNotEmpty) {
      return SizedBox(
        height: heightOfList,
        child: ListView.separated(
          itemCount: carts.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, state) {
            return const SizedBox(width: 16);
          },
          itemBuilder: (context, index) {
            final item = carts[index];
            return ShowOrderItem(
              imageUrl: item.imageUrl,
              title: item.title,
              price: item.price,
              count: item.productCount,
            );
          },
        ),
      );
    } else {
      return CustomText(text: S.of(context).homeNoProduct, fontSize: 16);
    }
  }
}

class ShowOrderItem extends StatelessWidget {
  const ShowOrderItem({
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 168,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade500.withAlpha(32)
                : Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            //  fit: BoxFit.contain,
            errorWidget: (error, url, x) {
              return const Icon(Icons.image);
            },
            imageUrl: imageUrl,
          ),
        ),
        const SizedBox(height: 8),
        CustomText(
          text: title.split(" ").take(2).join(" "),
          fontSize: 16,
          alignment: Alignment.centerLeft,
        ),
        CustomText(
          text: '${priceShowed(price)} ${S.of(context).EP}',
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
