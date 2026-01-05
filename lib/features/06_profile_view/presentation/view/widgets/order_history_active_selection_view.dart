import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_dialog_state.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/order_model.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_state.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/order_history_item.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:intl/intl.dart';

class OrderHistoryActiveSelectionView extends StatefulWidget {
  const OrderHistoryActiveSelectionView({
    super.key,
    required this.orders,
    required this.selectedOrders,
    required this.onCancel,
  });

  final List<OrderModel> orders;
  final List<OrderModel> selectedOrders;
  final VoidCallback onCancel;

  @override
  State<OrderHistoryActiveSelectionView> createState() =>
      _OrderHistoryActiveSelectionViewState();
}

class _OrderHistoryActiveSelectionViewState
    extends State<OrderHistoryActiveSelectionView> {
  final ValueNotifier<Map<String, bool>> activeItems = ValueNotifier({});

  @override
  void initState() {
    super.initState();
    // نزامن selectedOrders الأولية مع activeItems
    activeItems.value = {
      for (var order in widget.selectedOrders) order.orderId: true,
    };
  }

  bool _isAllSelected(Map<String, bool> selected) =>
      selected.length == widget.orders.length && widget.orders.isNotEmpty;

  bool _isAnySelected(Map<String, bool> selected) => selected.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<Map<String, bool>>(
          valueListenable: activeItems,
          builder: (context, selectedMap, _) => _buildTopBar(selectedMap),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ValueListenableBuilder<Map<String, bool>>(
            valueListenable: activeItems,
            builder: (context, selectedMap, _) {
              return ListView.separated(
                itemCount: widget.orders.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (context, index) {
                  final order = widget.orders[index];
                  final id = order.orderId;
                  final isSelected = selectedMap[id] ?? false;

                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => _selectOnly(order),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                OrderHistoryItem(orderModel: order),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _toggleItem(order, isSelected),
                          icon: Icon(
                            isSelected
                                ? Icons.check_circle_rounded
                                : Icons.circle_outlined,
                            color: isSelected ? kPrimaryColor : kGreyColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar(Map<String, bool> selectedMap) {
    final isAllSelected = _isAllSelected(selectedMap);
    final isAnySelected = _isAnySelected(selectedMap);

    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: _undoSelected,
                    icon: Iconify(
                      Carbon.undo,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade100
                          : Colors.black,
                      size: 24,
                    ),
                  ),
                  IconWithCircleStyle(
                    onPressed: _confirmDelete,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  CustomText(
                    text: isAnySelected
                        ? S
                              .of(context)
                              .deleteNumOfItems(
                                context,
                                widget.selectedOrders.length,
                              )
                        : '',
                    fontSize: 14,
                    alignment: Alignment.center,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: isAllSelected
                        ? S.of(context).orderUnselected
                        : S.of(context).orderSelected,
                    fontSize: 14,
                    color: isAllSelected ? kPrimaryColor : kGreyColor,
                    alignment: Alignment.center,
                  ),
                  IconButton(
                    onPressed: () => _onSelectAllPressed(isAllSelected),
                    icon: Icon(
                      isAllSelected
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank_outlined,
                      color: isAllSelected ? kPrimaryColor : kGreyColor,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSelectAllPressed(bool isAllSelected) {
    if (!isAllSelected) {
      _selectAll();
    } else {
      _unselectAllButStayActive();
    }
  }

  void _selectOnly(OrderModel order) {
    widget.selectedOrders
      ..clear()
      ..add(order);
    activeItems.value = {order.orderId: true};
  }

  void _toggleItem(OrderModel order, bool isSelected) {
    final updated = Map<String, bool>.from(activeItems.value);
    final id = order.orderId;

    if (isSelected) {
      updated.remove(id);
      widget.selectedOrders.removeWhere((e) => e.orderId == id);
    } else {
      updated[id] = true;
      widget.selectedOrders.add(order);
    }
    activeItems.value = updated;
  }

  void _selectAll() {
    final allSelected = {for (var order in widget.orders) order.orderId: true};
    activeItems.value = allSelected;
    widget.selectedOrders
      ..clear()
      ..addAll(widget.orders);
  }

  void _unselectAllButStayActive() {
    activeItems.value = {};
    widget.selectedOrders.clear();
  }

  void _undoSelected() {
    activeItems.value = {};
    widget.selectedOrders.clear();
    widget.onCancel();
  }

  void _confirmDelete() {
    if (widget.selectedOrders.isEmpty) return;
    warningAwesomeDialog(
      context,
      title: S.of(context).orderDeleteHistory,
      description: S
          .of(context)
          .areYouSureToDeleteItems(context, widget.selectedOrders.length),
      buttonAcceptText: S.of(context).warning_button_title_ok,
      buttonCancelText: S.of(context).warning_button_title_Cancel,
      onPressed: () {
        context.read<OrderCubit>().deleteMultipleOrders(
          orders: widget.selectedOrders,
        );
        widget.onCancel();
      },
      cancelOnPressed: widget.onCancel,
    );
  }
}
