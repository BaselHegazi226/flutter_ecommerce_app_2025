import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/cart_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/cart_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';

import '../../../../core/utilities/custom_text.dart';
import '../../../../generated/l10n.dart';
import '../view_model/cart_bloc/cart_state.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetCartCubit(cartCache: AppGet().getIt<CartCacheImplement>())
                ..getCartProductsAndTotal(),
        ),
        BlocProvider(
          create: (context) =>
              CartBloc(cartCache: AppGet().getIt<CartCacheImplement>()),
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
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: CustomText(text: S.of(context).Cart, fontSize: 20),
              centerTitle: true,
            ),
            body: const CartViewBody(),
          ),
        ),
      ),
    );
  }
}
