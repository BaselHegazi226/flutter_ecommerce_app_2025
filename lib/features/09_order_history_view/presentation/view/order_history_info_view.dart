import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view/widgets/order_history_info_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view_model/order_info_cubit/order_info_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../generated/l10n.dart';

class OrderHistoryInfoView extends StatelessWidget {
  const OrderHistoryInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderInfoCubit(orderCache: AppGet().getIt<OrderCacheImplement>())
            ..getOrderHistoryInfo(),
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(context, S.of(context).cartOrderInfo, () {
            GoRouter.of(context).pop();
          }),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocListener<OrderInfoCubit, OrderInfoState>(
              listener: (context, state) {
                if (state is SaveHistoryOrderInfoSuccess) {
                  //trigger info of order
                  context.read<OrderInfoCubit>().getOrderHistoryInfo();
                  //notification with success/failure
                  ToastNotification.flatColoredToastNotificationService(
                    onAutoCompleteCompleted: (_) {},
                    title: S.of(context).success_update_order_info_title,
                    description: S.of(context).success_update_order_info_desc,
                    toastNotificationType: ToastificationType.success,
                  );
                } else if (state is SaveHistoryOrderInfoFailure) {
                  ToastNotification.flatColoredToastNotificationService(
                    onAutoCompleteCompleted: (_) {},
                    title: S.of(context).failure_update_order_info_title,
                    description: S.of(context).failure_update_order_info_desc,
                    toastNotificationType: ToastificationType.error,
                  );
                }
              },
              child: const OrderInfoViewBody(),
            ),
          ),
        ),
      ),
    );
  }
}
