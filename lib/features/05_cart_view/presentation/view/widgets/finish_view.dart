import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';
import 'package:intl/intl.dart';

class FinishView extends StatelessWidget {
  const FinishView({
    super.key,
    required this.orderModel,
    required this.onBack,
    required this.onNext,
  });
  final OrderModel? orderModel;
  final VoidCallback onBack, onNext;
  @override
  Widget build(BuildContext context) {
    if (orderModel == null) {
      return const Center(
        child: CustomText(
          text: 'Order Data Not Found',
          fontSize: 18,
          alignment: Alignment.center,
          color: kPrimaryWrongColor,
        ),
      );
    } else {
      return Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: 'Order Done Successfully',
                fontSize: 18,
                alignment: Alignment.center,
              ),
              Icon(Icons.check_circle, color: kPrimaryColor),
            ],
          ),
          const SizedBox(height: 36),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: DateFormat(
                      'MMMM dd, yyyy',
                    ).format(orderModel!.checkoutDateAt).toString(),
                    fontSize: 14,
                    color: kGreyColor,
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    color: orderStateData(orderModel!.orderState)['color'],
                    padding: const EdgeInsets.all(8),
                    child: CustomText(
                      text: orderStateData(orderModel!.orderState)['state'],
                      fontSize: 14,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TrackOrderItem(
                imageUrl: orderModel!.cartModelList[0].imageUrl,
                orderNumber: orderModel!.orderId,
                totalPrice: orderModel!.totalPrice,
                onBack: onBack,
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  child: CustomButton(onPressed: onNext, text: 'Finish'),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Map<String, dynamic> orderStateData(OrderState orderState) {
    switch (orderState) {
      case OrderState.delivered:
        return {'color': kPrimaryColor, 'state': 'delivered'};
      case OrderState.transmit:
        return {'color': Colors.yellow.shade700, 'state': 'delivered'};
      default:
        return {'color': kGreyColor, 'state': 'pending'};
    }
  }
}

class TrackOrderItem extends StatelessWidget {
  const TrackOrderItem({
    super.key,
    required this.imageUrl,
    required this.orderNumber,
    required this.totalPrice,
    required this.onBack,
  });
  final String imageUrl;
  final String orderNumber;
  final double totalPrice;
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                  text: 'OD-${orderNumber.split('-').take(2).join('-')}-N',
                  fontSize: 16,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 16),
                CustomText(
                  text: '\$ $totalPrice',
                  fontSize: 18,
                  color: kPrimaryColor,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: onBack,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      CustomText(
                        text: 'Cancel Order',
                        fontSize: 16,
                        alignment: Alignment.centerLeft,
                        color: kPrimaryWrongColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
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
        ],
      ),
    );
  }
}
