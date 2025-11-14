import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:intl/intl.dart';

import '../../../../../generated/l10n.dart';
import '../../../data/model/order_model.dart';
import '../../view_model/checkout_cubit/checkout_cubit.dart';

class FinishView extends StatelessWidget {
  const FinishView({
    super.key,
    required this.orderModel,
    required this.onBack,
    required this.onFinish,
  });

  final OrderModel? orderModel;
  final VoidCallback onBack;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        // لو الحالة نجاح، خد الموديل الجديد
        final updatedOrder = (state is OrderReadySuccess)
            ? state.order
            : orderModel;

        if (updatedOrder == null) {
          return const Center(
            child: CustomText(
              text: 'Order Data Not Found',
              fontSize: 18,
              alignment: Alignment.center,
              color: kPrimaryWrongColor,
            ),
          );
        }

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: S.of(context).OrderIsReady,
                  fontSize: 18,
                  alignment: Alignment.center,
                  color: Colors.grey.shade900,
                ),
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade200
                      : kPrimaryColor,
                ),
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
                      ).format(updatedOrder.checkoutDateAt).toString(),
                      fontSize: 14,
                      color: kGreyColor,
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      color: orderStateData(
                        context,
                        updatedOrder.orderStateEnum,
                      )['color'],
                      padding: const EdgeInsets.all(8),
                      child: CustomText(
                        text: orderStateData(
                          context,
                          updatedOrder.orderStateEnum,
                        )['state'],
                        fontSize: 14,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _customTrackOrderItem(context, updatedOrder, screenSize),
              ],
            ),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  const Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    child: CustomButton(
                      onPressed: onFinish,
                      text: S.of(context).Finish,
                      textColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade600
                          : Colors.grey.shade200,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade200
                          : kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _customTrackOrderItem(BuildContext context, OrderModel order, Size size) {
    return Container(
      height: 175,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade100
              : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade700
                : Colors.grey.shade100,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'OD-${order.orderId.split('-').take(2).join('-')}-N',
                  fontSize: 16,
                ),
                const SizedBox(height: 16),
                CustomText(
                  text: '\$ ${order.totalPrice.toStringAsFixed(2)}',
                  fontSize: 18,
                  color: kPrimaryColor,
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: onBack,
                  child: Row(
                    children: [
                      CustomText(
                        text: S.of(context).CancelOrder,
                        fontSize: 16,
                        alignment: Alignment.centerLeft,
                        color: kPrimaryWrongColor,
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.red,
                        size: 20,
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
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade500
                    : Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: ListView.builder(
                itemCount: orderModel!.cartModelList.length,
                itemBuilder: (context, index) {
                  final item = orderModel!.cartModelList[index];
                  if (orderModel!.cartModelList.length > 1) {
                    return Column(
                      children: [
                        _customImage(item.imageUrl),
                        index < orderModel!.cartModelList.length - 1
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                height: 2,
                              )
                            : const SizedBox(),
                      ],
                    );
                  }
                  return _customImage(item.imageUrl);
                },
              ),
            ),
          ),
        ],
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

Map<String, dynamic> orderStateData(
  BuildContext context,
  OrderStateEnum orderState,
) {
  switch (orderState) {
    case OrderStateEnum.delivered:
      return {'color': kPrimaryColor, 'state': S.of(context).Delivered};
    case OrderStateEnum.transmit:
      return {'color': Colors.yellow.shade700, 'state': S.of(context).Transmit};
    default:
      return {'color': kGreyColor, 'state': S.of(context).Pending};
  }
}
