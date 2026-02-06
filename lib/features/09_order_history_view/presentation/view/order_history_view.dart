import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view/widgets/order_history_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view_model/delete_order_cubit/delete_order_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view_model/order_info_cubit/order_info_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/routes.dart';
import '../../../../generated/l10n.dart';
import '../view_model/get_orders_cubit/get_orders_cubit.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetOrdersCubit(orderCache: AppGet().getIt<OrderCacheImplement>())
                ..getOrderList(),
        ),
        BlocProvider(
          create: (context) =>
              OrderInfoCubit(orderCache: AppGet().getIt<OrderCacheImplement>())
                ..getOrderHistoryInfo(),
        ),
        BlocProvider(
          create: (context) => DeleteOrderCubit(
            orderCache: AppGet().getIt<OrderCacheImplement>(),
          ),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: CustomText(
              text: S.of(context).orderHistory,
              fontSize: 20,
              height: 1,
              maxLines: 1,
              fontWeight: FontWeight.w700,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    GoRouter.of(context).push(
                      '${Routes.orderHistoryView}${Routes.orderHistoryInfoView}',
                    );
                  },
                  child: Row(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: S.of(context).cartOrderInfo,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade50
                            : Colors.black87,
                      ),
                      Icon(
                        Icons.edit_location_alt_outlined,
                        size: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade50
                            : Colors.black87,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<DeleteOrderCubit, DeleteOrderState>(
                listener: (context, state) {
                  if (state is DeleteOrderSuccess ||
                      state is DeleteAllOrdersSuccess ||
                      state is DeleteMultipleOrdersSuccess) {
                    context.read<GetOrdersCubit>().getOrderList();
                  }
                },
              ),
              BlocListener<OrderInfoCubit, OrderInfoState>(
                listener: (context, state) {
                  if (state is SaveHistoryOrderInfoSuccess) {
                    context.read<OrderInfoCubit>().getOrderHistoryInfo();
                  }
                },
              ),
            ],
            child: const OrderHistoryViewBody(),
          ),
        ),
      ),
    );
  }
}
