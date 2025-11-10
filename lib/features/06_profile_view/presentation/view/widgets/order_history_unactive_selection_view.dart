import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/order_history_item.dart';
import 'package:intl/intl.dart';

class OrderHistoryUnactiveSelectionView extends StatelessWidget {
  const OrderHistoryUnactiveSelectionView({
    super.key,
    required this.orders,
    required this.onActivate,
  });

  final List<OrderModel> orders;
  final Function(OrderModel orderModel) onActivate;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 8,
            children: [
              CustomText(
                text: DateFormat(
                  'MMMM dd, yyyy',
                ).format(order.checkoutDateAt).toString(),
                fontSize: 14,
                color: kGreyColor,
                alignment: Alignment.centerLeft,
              ),

              InkWell(
                onLongPress: () => onActivate(order),
                child: OrderHistoryItem(orderModel: order),
              ),
            ],
          ),
        );
      },
    );
  }
}
