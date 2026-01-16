import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view/widgets/checkout_view_body.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utilities/app_get.dart';
import '../../../../core/utilities/toastnotification.dart';
import '../view_model/cart_bloc/cart_bloc.dart';
import '../view_model/checkout_cubit/checkout_cubit.dart';
import '../view_model/get_cart_cubit/get_cart_cubit.dart';
import '../view_model/order_cubit/order_cubit.dart';
import '../view_model/payment_bloc/payment_bloc.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.cartBloc,
    required this.getCartCubit,
  });

  final CartBloc cartBloc;
  final GetCartCubit getCartCubit;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.getCartCubit),
        BlocProvider(
          create: (context) =>
              OrderCubit(orderCache: AppGet().getIt<OrderCacheImplement>())
                ..getUserLocation(),
        ),
        BlocProvider.value(value: widget.cartBloc),
        BlocProvider(
          create: (context) => CheckoutCubit(
            orderCubit: context.read<OrderCubit>(),
            getCartCubit: widget.getCartCubit,
            cartBloc: widget.cartBloc,
          ),
        ),
        BlocProvider(create: (context) => PaymentBloc()),
      ],
      child: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is ConfirmOrderSuccess) {
            ToastNotification.flatColoredToastNotificationService(
              onAutoCompleteCompleted: (value) {},
              title: S.of(context).success_add_order_title,
              description: S.of(context).success_add_order_desc,
            );
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            }
          } else if (state is ConfirmOrderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).error(state.errorMessage)),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: CheckoutViewBody(),
          ),
        ),
      ),
    );
  }
}
