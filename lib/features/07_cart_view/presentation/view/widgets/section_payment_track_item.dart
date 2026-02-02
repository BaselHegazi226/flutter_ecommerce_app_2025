import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';

import '../../../data/model/order_model.dart';

class SectionPaymentTrackItem extends StatelessWidget {
  const SectionPaymentTrackItem({super.key, required this.orderModel});

  final OrderModel? orderModel;

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      mobileWidget: SectionPaymentTrackItemMobile(orderModel: orderModel),
      tabletWidget: SectionPaymentTrackItemTablet(orderModel: orderModel),
    );
  }
}

class SectionPaymentTrackItemMobile extends StatelessWidget {
  const SectionPaymentTrackItemMobile({super.key, this.orderModel});

  final OrderModel? orderModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: orderModel!.cartModelList.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // خلي اتنين جنب بعض
        crossAxisSpacing: 16, // مسافة أفقية بين العناصر
        mainAxisSpacing: 16, // مسافة رأسية بين العناصر
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final product = orderModel!.cartModelList[index];
        return buildItem(context, product.imageUrl);
      },
    );
  }

  buildItem(BuildContext context, String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade500.withAlpha(32)
            : Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: FittedBox(fit: BoxFit.scaleDown, child: _customImage(imageUrl)),
    );
  }

  Widget _customImage(String imageUrl) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) {
        return const Icon(Icons.image_not_supported_outlined);
      },
      imageUrl: imageUrl,
    );
  }
}

class SectionPaymentTrackItemTablet extends StatelessWidget {
  const SectionPaymentTrackItemTablet({super.key, this.orderModel});

  final OrderModel? orderModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: orderModel!.cartModelList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // خلي اتنين جنب بعض
        crossAxisSpacing: 16, // مسافة أفقية بين العناصر
        mainAxisSpacing: 16, // مسافة رأسية بين العناصر
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final product = orderModel!.cartModelList[index];
        return buildItem(context, product.imageUrl);
      },
    );
  }

  buildItem(BuildContext context, String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade500.withAlpha(32)
            : Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: FittedBox(fit: BoxFit.scaleDown, child: _customImage(imageUrl)),
    );
  }

  Widget _customImage(String imageUrl) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) {
        return const Icon(Icons.image_not_supported_outlined);
      },
      imageUrl: imageUrl,
    );
  }
}
