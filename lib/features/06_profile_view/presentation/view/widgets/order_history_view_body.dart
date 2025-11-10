import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/not_item_found.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_state.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/order_history_selection_class.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';

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
          if (orders.isEmpty) {
            return const NoItemFound(
              itemTitle: 'No History found try make order!',
              itemImage: Assets.profileNoHistoryOrder,
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
