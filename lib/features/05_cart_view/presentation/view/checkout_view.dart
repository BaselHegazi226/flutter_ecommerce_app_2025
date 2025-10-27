import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/checkout_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/checkout_cubit/checkout_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';

import '../../../../core/cache/cart_cache.dart';
import '../../../../core/utilities/app_get.dart';
import '../view_model/cart_bloc/cart_bloc.dart';
import '../view_model/get_cart_cubit/get_cart_cubit.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetCartCubit(
            cartCache: AppGet().getIt<CartCacheImplement>()
              ..getCartTotalPrice(),
          ),
        ),
        BlocProvider(
          create: (context) => CheckoutCubit(
            orderCubit: OrderCubit(
              orderCache: AppGet().getIt<OrderCacheImplement>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) =>
              CartBloc(cartCache: AppGet().getIt<CartCacheImplement>()),
        ),
      ],
      child: const SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: CheckoutViewBody(),
        ),
      ),
    );
  }
}
