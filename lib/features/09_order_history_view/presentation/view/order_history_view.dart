import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view/widgets/order_history_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view_model/delete_order_cubit/delete_order_cubit.dart';

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
          create: (context) => DeleteOrderCubit(
            orderCache: AppGet().getIt<OrderCacheImplement>(),
          ),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: customTabsAppbar(context, S.of(context).orderHistory),
          body: BlocListener<DeleteOrderCubit, DeleteOrderState>(
            listener: (context, state) {
              if (state is DeleteOrderSuccess ||
                  state is DeleteAllOrdersSuccess ||
                  state is DeleteMultipleOrdersSuccess) {
                context.read<GetOrdersCubit>().getOrderList();
              }
            },
            child: const OrderHistoryViewBody(),
          ),
        ),
      ),
    );
  }
}
