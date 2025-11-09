import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/checkout_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/checkout_cubit/checkout_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utilities/app_get.dart';
import '../../../../core/utilities/toastnotification.dart';
import '../view_model/cart_bloc/cart_bloc.dart';
import '../view_model/get_cart_cubit/get_cart_cubit.dart';

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
      ],
      child: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is ConfirmOrderSuccess) {
            ToastNotification.flatColoredToastNotificationService(
              onAutoCompleteCompleted: (value) {},
              title: 'Success Make Order',
            );
            debugPrint('we will delete cart');
            GoRouter.of(context).pop();
          } else if (state is ConfirmOrderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
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
