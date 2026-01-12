import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_order_list.dart';

import '../../../../../core/helper/date_formatter.dart';
import '../../../../../core/helper/extensions_of_s_localization.dart';
import '../../../../../generated/l10n.dart';
import '../../../../07_cart_view/data/model/order_model.dart';

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
        final cart = order.cartModelList;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              CustomText(
                text: DateFormatter.format(
                  order.checkoutDateAt,
                  S.of(context).orderHistory,
                ),
                fontSize: 14,
                color: kGreyColor,
              ),

              InkWell(
                onLongPress: () => onActivate(order),
                child: Column(
                  children: [
                    ShowOrderList(carts: cart),
                    const SizedBox(height: 16),
                    Container(
                      height: 1,
                      color: index < cart.length
                          ? Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade50
                                : Colors.black26
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
