import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/cart_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
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
    return BlocBuilder<GetCartCubit, GetCartState>(
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
        return CustomLayout(
          mobileWidget: cartViewItemShimmerListMobile(screenSize),
          tabletWidget: cartViewItemShimmerListTablet(screenSize),
        );
      },
    );
  }
}
