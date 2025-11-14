import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/price_button_section.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/cart_bloc/cart_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_state.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/l10n.dart';

class CartViewTotalCheckoutSection extends StatelessWidget {
  const CartViewTotalCheckoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartCubit, GetCartState>(
      builder: (context, state) {
        if (state is GetProductCartAndTotalSuccess) {
          debugPrint('success totallllllllllllllll');
          return PriceButtonSection(
            title: S.of(context).Total,
            value: '\$ ${state.totalPrice.roundToDouble()}',
            widget: CustomButton(
              onPressed: () {
                GoRouter.of(context).push(
                  '${Routes.cartView}${Routes.checkoutView}',
                  extra: {
                    'cart_bloc': context.read<CartBloc>(),
                    'get_cart_cubit': context.read<GetCartCubit>(),
                  },
                );
              },
              text: S.of(context).Checkout,
              textColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade600
                  : Colors.grey.shade200,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade200
                  : kPrimaryColor,
            ),
          );
        } else if (state is GetProductCartAndTotalFailure) {
          debugPrint('failure totallllllllllllllll = ${state.errorMessage}');
          return PriceButtonSection(
            title: S.of(context).Total,
            value: state.errorMessage,
            widget: CustomButton(
              onPressed: null,
              text: S.of(context).Checkout,
              backgroundColor: kPrimaryColor,
            ),
          );
        } else {
          debugPrint('loading totallllllllllllllll');
          return const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCircleIndicator(color: kPrimaryColor),
              CustomButton(
                onPressed: null,
                text: 'CHECKOUT',
                backgroundColor: kPrimaryColor,
              ),
            ],
          );
        }
      },
    );
  }
}
