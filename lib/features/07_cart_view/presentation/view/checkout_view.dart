import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view/widgets/checkout_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utilities/toastnotification.dart';
import '../view_model/cart_bloc/cart_bloc.dart';
import '../view_model/checkout_cubit/checkout_cubit.dart';
import '../view_model/get_cart_cubit/get_cart_cubit.dart';
import '../view_model/get_cart_cubit/get_cart_state.dart';
import '../view_model/payment_bloc/payment_bloc.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.cartBloc,
    required this.getCartCubit,
    required this.checkoutCubit,
  });

  final CartBloc cartBloc;
  final GetCartCubit getCartCubit;
  final CheckoutCubit checkoutCubit;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.getCartCubit),
        BlocProvider.value(value: widget.cartBloc),
        BlocProvider.value(value: widget.checkoutCubit),
        BlocProvider(create: (context) => PaymentBloc()),
        BlocProvider(
          create: (context) =>
              OrderCubit(orderCache: AppGet().getIt<OrderCacheImplement>())
                ..getOrderInfo(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<GetCartCubit, GetCartState>(
            listener: (context, state) {
              if (state is GetProductCartAndTotalSuccess ||
                  state is GetProductCartAndTotalSuccessOnline) {
                final cartList = (state is GetProductCartAndTotalSuccess)
                    ? state.carts
                    : (state as GetProductCartAndTotalSuccessOnline).carts;
                final totalPrice = (state is GetProductCartAndTotalSuccess)
                    ? state.totalPrice
                    : (state as GetProductCartAndTotalSuccessOnline).totalPrice;
                debugPrint('total price in checkout view = $totalPrice');
                for (var item in cartList) {
                  debugPrint(
                    'item of cart list in in checkout view = ${item.toJson()} =====>',
                  );
                }

                context.read<CheckoutCubit>().setCartData(
                  totalPrice: totalPrice,
                  cartList: cartList,
                );
              }
            },
          ),
          BlocListener<CheckoutCubit, CheckoutState>(
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
          ),
          BlocListener<CheckoutCubit, CheckoutState>(
            listener: (context, state) {
              if (state is FillOrderInfoDone) {
                context.read<OrderCubit>().saveUserInfo(
                  orderInfoModel: state.orderInfoModel,
                );
              }
            },
          ),
        ],
        child: const Scaffold(body: CheckoutViewBody()),
      ),
    );
  }
}
