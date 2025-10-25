import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/cart_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/cart_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';

import '../view_model/cart_bloc/cart_state.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build cart view');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = GetCartCubit(
              cartCache: AppGet().getIt<CartCacheImplement>(),
            );
            cubit.getCartProductsAndTotal();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) =>
              CartBloc(cartCache: AppGet().getIt<CartCacheImplement>()),
        ),
      ],
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is UpdateProductCountSuccess ||
              state is DeleteProductSuccess) {
            context.read<GetCartCubit>().getCartProductsAndTotal();
          }
        },
        child: const SafeArea(child: Scaffold(body: CartViewBody())),
      ),
    );
  }
}
