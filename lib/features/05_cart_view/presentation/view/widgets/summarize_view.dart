import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/summarize_products_order_list.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/checkout_cubit/checkout_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_state.dart';

import '../../../../../core/utilities/custom_button.dart';

class SummarizeView extends StatefulWidget {
  const SummarizeView({super.key, required this.onNext, required this.onBack});
  final VoidCallback onNext, onBack;

  @override
  State<SummarizeView> createState() => _SummarizeViewState();
}

class _SummarizeViewState extends State<SummarizeView> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return BlocBuilder<GetCartCubit, GetCartState>(
      builder: (context, state) {
        if (state is GetProductCartAndTotalFailure) {
          return CustomText(
            text: state.errorMessage,
            fontSize: 18,
            alignment: Alignment.center,
          );
        } else if (state is GetProductCartAndTotalSuccess) {
          final carts = state.carts;
          final totalPrice = state.totalPrice;
          cubit.setCartData(totalPrice: totalPrice, cartList: carts);
          return Column(
            children: [
              SummarizeProductsOrderList(carts: carts),
              Container(height: 1, color: kGreyColor),
              const SizedBox(height: 16),
              CustomText(
                text: cubit.getDeliveryMethodModel!.title,
                fontSize: 18,
                alignment: Alignment.centerLeft,
                color: Colors.grey.shade900,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Street1: ${cubit.getLocationModel?.street1}\nStreet2: ${cubit.getLocationModel?.street2}\nCity: ${cubit.getLocationModel?.city}\nState: ${cubit.getLocationModel?.state}\nCountry: ${cubit.getLocationModel?.country}',
                      softWrap: true,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade200
                        : kPrimaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Total price',
                    fontSize: 18,
                    alignment: Alignment.centerLeft,
                    color: Colors.grey.shade900,
                  ),
                  CustomText(
                    text: '\$ ${totalPrice.toStringAsFixed(2)}',
                    fontSize: 16,
                    alignment: Alignment.centerLeft,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade200
                        : kPrimaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: CustomButton(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade700
                            : kScaffoldColor,
                        borderColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryColor,
                        onPressed: widget.onBack,
                        text: 'Back',
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          if (cubit.getLocationModel == null ||
                              cubit.getDeliveryMethodModel == null) {
                            return;
                          }

                          widget.onNext();
                          debugPrint(
                            'location model = ${cubit.getLocationModel?.toJson()} from summarize view=============================>',
                          );
                          debugPrint(
                            'location model = ${cubit.getDeliveryMethodModel?.toJson()} from summarize view=============================>',
                          );
                        },
                        text: 'Deliver',
                        textColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade600
                            : Colors.grey.shade200,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade200
                            : kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        } else {
          return const CustomCircleIndicator(color: kPrimaryColor);
        }
      },
    );
  }
}
