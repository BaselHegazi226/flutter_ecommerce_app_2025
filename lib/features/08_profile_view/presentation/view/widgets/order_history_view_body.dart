import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/not_item_found.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../07_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import '../../../../07_cart_view/presentation/view_model/order_cubit/order_state.dart';
import 'order_history_selection_class.dart';

class OrderHistoryViewBody extends StatefulWidget {
  const OrderHistoryViewBody({super.key});

  @override
  State<OrderHistoryViewBody> createState() => _OrderHistoryViewBodyState();
}

class _OrderHistoryViewBodyState extends State<OrderHistoryViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is DeleteMultipleOrdersSuccess ||
            state is DeleteAllOrdersSuccess) {
          context.read<OrderCubit>().getOrderList();
        }
      },
      builder: (context, state) {
        if (state is GetOrderListSuccess) {
          final orders = state.orders;
          debugPrint('order length = ${orders.length} ==============>');
          if (orders.isEmpty) {
            return Center(
              child: NoItemFound(
                itemTitle: S.of(context).orderHistoryNoOrdersFound,
                itemImage: Assets.profileNoHistoryOrder,
              ),
            );
          }
          return OrderHistorySelectionClass(orders: orders);
        } else if (state is GetOrderListFailure) {
          return Center(
            child: CustomText(
              text: state.errorMessage,
              fontSize: 16,
              alignment: Alignment.center,
            ),
          );
        } else {
          return const CustomCircleIndicator(color: kPrimaryColor);
        }
      },
    );
  }
}
