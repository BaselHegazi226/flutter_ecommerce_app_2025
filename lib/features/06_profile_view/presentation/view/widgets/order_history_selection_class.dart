import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';

import 'order_history_active_selection_view.dart';
import 'order_history_unactive_selection_view.dart';

class OrderHistorySelectionClass extends StatefulWidget {
  const OrderHistorySelectionClass({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  State<OrderHistorySelectionClass> createState() =>
      _OrderHistorySelectionClassState();
}

class _OrderHistorySelectionClassState
    extends State<OrderHistorySelectionClass> {
  final ValueNotifier<bool> activeSelectedMode = ValueNotifier(false);
  final List<OrderModel> selectedOrders = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: activeSelectedMode,
      builder: (context, isActive, _) {
        return isActive
            ? OrderHistoryActiveSelectionView(
                orders: widget.orders,
                selectedOrders: selectedOrders,
                onCancel: () => activeSelectedMode.value = false,
              )
            : OrderHistoryUnactiveSelectionView(
                orders: widget.orders,
                onActivate: (OrderModel orderModel) {
                  selectedOrders
                    ..clear()
                    ..add(orderModel);
                  activeSelectedMode.value = true;
                },
              );
      },
    );
  }
}
