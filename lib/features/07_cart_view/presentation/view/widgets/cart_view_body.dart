import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/cart_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view_model/checkout_cubit/checkout_cubit.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';

import '../../../../../core/utilities/not_item_found.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/get_cart_cubit/get_cart_cubit.dart';
import '../../view_model/get_cart_cubit/get_cart_state.dart';
import 'cart_view_list_section.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<GetCartCubit>().getCartProductsAndTotal();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return BlocConsumer<GetCartCubit, GetCartState>(
      listener: (context, state) {
        if (state is GetProductCartAndTotalSuccess ||
            state is GetProductCartAndTotalSuccessOnline) {
          final cartList = (state is GetProductCartAndTotalSuccess)
              ? state.carts
              : (state as GetProductCartAndTotalSuccessOnline).carts;
          final totalPrice = (state is GetProductCartAndTotalSuccess)
              ? state.totalPrice
              : (state as GetProductCartAndTotalSuccessOnline).totalPrice;
          debugPrint('total price in cart view = $totalPrice');
          for (var item in cartList) {
            debugPrint(
              'item of cart list in in cart view = ${item.toJson()} =====>',
            );
          }
          context.read<CheckoutCubit>().setCartData(
            totalPrice: totalPrice,
            cartList: cartList,
          );
        }
      },
      builder: (context, state) {
        if (state is GetProductCartAndTotalSuccess ||
            state is GetProductCartAndTotalSuccessOnline) {
          final cartList = (state is GetProductCartAndTotalSuccess)
              ? state.carts
              : (state as GetProductCartAndTotalSuccessOnline).carts;
          if (cartList.isEmpty) {
            return NoItemFound(
              itemTitle: S.of(context).cartTryToFill,
              itemImage: Assets.cartEmptyCart,
            );
          }
          return CartViewListSection(
            screenSize: screenSize,
            cartList: cartList,
          );
        } else if (state is GetProductCartAndTotalFailure) {
          return Center(child: Text(state.errorMessage));
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: CustomLayout(
            mobileWidget: cartViewItemShimmerListMobile(screenSize),
            tabletWidget: cartViewItemShimmerListTablet(screenSize),
          ),
        );
      },
    );
  }
}
