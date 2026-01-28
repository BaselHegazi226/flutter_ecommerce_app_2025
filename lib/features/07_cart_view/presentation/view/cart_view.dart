import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view/widgets/cart_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view_model/checkout_cubit/checkout_cubit.dart';

import '../../../../core/cache/order_cache.dart';
import '../../../../generated/l10n.dart';
import '../view_model/cart_bloc/cart_bloc.dart';
import '../view_model/cart_bloc/cart_state.dart';
import '../view_model/get_cart_cubit/get_cart_cubit.dart';
import '../view_model/order_cubit/order_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetCartCubit>(
          create: (_) =>
              AppGet().getIt<GetCartCubit>()..getCartProductsAndTotal(),
        ),
        BlocProvider<CartBloc>(create: (_) => AppGet().getIt<CartBloc>()),
        BlocProvider(
          create: (context) =>
              OrderCubit(orderCache: AppGet().getIt<OrderCacheImplement>()),
        ),
        BlocProvider(
          create: (context) => CheckoutCubit(
            orderCubit: context.read<OrderCubit>(),
            getCartCubit: AppGet().getIt<GetCartCubit>(),
            cartBloc: AppGet().getIt<CartBloc>(),
          ),
        ),
      ],
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is UpdateProductCountSuccess ||
              state is DeleteProductSuccess ||
              state is DeleteAllProductSuccess) {
            context.read<GetCartCubit>().getCartProductsAndTotal();
          }
        },

        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: customTabsAppbar(context, S.of(context).navCart),
          body: const CartViewBody(),
        ),
      ),
    );
  }
}
