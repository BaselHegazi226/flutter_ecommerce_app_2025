import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(children: [detailsSection(context), imageSection()]),
    );
  }

  Expanded detailsSection(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'OD-${orderModel.orderId.split('-').take(2).join('-')}-N',
            fontSize: 16,
            color: Colors.grey.shade900,
          ),
          const SizedBox(height: 16),
          CustomText(
            text: '${priceShowed(orderModel.totalPrice)} ${S.of(context).EP}',
            fontSize: 18,
            color: kPrimaryColor,
          ),
          const SizedBox(height: 32),
          Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: orderStateData(
                context,
                orderModel.orderStateEnum,
              )['color'],
              borderRadius: BorderRadius.circular(4),
            ),
            child: CustomText(
              text: orderStateData(context, orderModel.orderStateEnum)['state'],
              fontSize: 14,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }

  Expanded imageSection() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.all(4),
        child: ListView.builder(
          itemCount: orderModel.cartModelList.length,
          itemBuilder: (context, index) {
            final item = orderModel.cartModelList[index];
            if (orderModel.cartModelList.length > 1) {
              return Column(
                children: [
                  _customImage(item.imageUrl),
                  index < orderModel.cartModelList.length - 1
                      ? Container(color: Colors.white, height: 4)
                      : const SizedBox(),
                ],
              );
            }
            return _customImage(item.imageUrl);
          },
        ),
      ),
    );
  }

  Widget _customImage(String imageUrl) {
    return AspectRatio(
      aspectRatio: .75,
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        errorWidget: (context, url, error) {
          return const Icon(Icons.image_not_supported_outlined);
        },
        imageUrl: imageUrl,
      ),
    );
  }
}
