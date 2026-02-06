import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/not_item_found.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view_model/get_orders_cubit/get_orders_cubit.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import 'order_history_selection_class.dart';

class OrderHistoryViewBody extends StatefulWidget {
  const OrderHistoryViewBody({super.key});

  @override
  State<OrderHistoryViewBody> createState() => _OrderHistoryViewBodyState();
}

class _OrderHistoryViewBodyState extends State<OrderHistoryViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrdersCubit, GetOrdersState>(
      builder: (context, state) {
        if (state is GetOrdersSuccess) {
          final orders = state.orders;
          if (orders.isEmpty) {
            return Center(
              child: NoItemFound(
                itemTitle: S.of(context).orderHistoryNoOrdersFound,
                itemImage: Assets.profileNoHistoryOrder,
              ),
            );
          }
          return OrderHistorySelectionClass(orders: orders);
        } else if (state is GetOrdersFailure) {
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

class OrderInfoSectionItem extends StatelessWidget {
  const OrderInfoSectionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 4,
          children: [
            Icon(icon, size: 24),
            CustomText(
              text: '$title : ',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        CustomText(text: value, fontSize: 14),
      ],
    );
  }
}
