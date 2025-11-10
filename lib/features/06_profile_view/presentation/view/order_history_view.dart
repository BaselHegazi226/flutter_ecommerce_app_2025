import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/order_history_view_body.dart';
import 'package:go_router/go_router.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderCubit(orderCache: AppGet().getIt<OrderCacheImplement>())
            ..getOrderList(),
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(context, 'Order History', () {
            GoRouter.of(context).pushReplacement(Routes.profileView);
          }),
          body: const OrderHistoryViewBody(),
        ),
      ),
    );
  }
}
