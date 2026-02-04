import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

import '../../../../../core/utilities/extensions_of_s_localization.dart';
import '../../../../../generated/l10n.dart';
import '../../../../07_cart_view/data/model/order_model.dart';

class DeliveryStateSection extends StatelessWidget {
  const DeliveryStateSection({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 4,
          children: [
            const Icon(Icons.delivery_dining_outlined, size: 24),
            CustomText(
              text: S.of(context).orderDeliveryState,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: itemIconColor(orderModel.orderStateEnum).color,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            spacing: 4,
            children: [
              Icon(
                itemIconColor(orderModel.orderStateEnum).iconData,
                size: 14,
                color: Colors.white,
              ),
              CustomText(
                text: orderModel.orderStateEnum.title(
                  context,
                  orderModel.orderStateEnum,
                ),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  OrderStateIconColor itemIconColor(OrderStateEnum orderStateEnum) {
    switch (orderStateEnum) {
      case OrderStateEnum.pending:
        return OrderStateIconColor.pending;
      case OrderStateEnum.transmit:
        return OrderStateIconColor.transmit;
      case OrderStateEnum.delivered:
        return OrderStateIconColor.delivered;
      default:
        return OrderStateIconColor.pending;
    }
  }
}

enum OrderStateIconColor {
  pending(Icons.access_time_outlined, Colors.orange),
  delivered(Icons.check_circle_outline, Colors.green),
  transmit(Icons.delivery_dining_outlined, Colors.blue),
  cancelled(Icons.remove_circle_outline, Colors.red);

  // متغيرات لكل عنصر
  final Color color;
  final IconData iconData;

  // Constructor
  const OrderStateIconColor(this.iconData, this.color);
}
