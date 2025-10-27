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
              const SizedBox(height: 24),
              Container(height: 1, color: kGreyColor),
              const SizedBox(height: 16),
              CustomText(
                text: cubit.getDeliveryMethodModel!.title,
                fontSize: 18,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Street1: ${cubit.getLocationModel?.street1}\nStreet2: ${cubit.getLocationModel?.street2}\nCity: ${cubit.getLocationModel?.city}\nState: ${cubit.getLocationModel?.state}\nCountry: ${cubit.getLocationModel?.country}',
                      softWrap: true,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const Icon(Icons.check_circle, color: kPrimaryColor),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Total price',
                    fontSize: 18,
                    alignment: Alignment.centerLeft,
                  ),
                  CustomText(
                    text: '\$ $totalPrice',
                    fontSize: 16,
                    alignment: Alignment.centerLeft,
                    color: kPrimaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: CustomButton(
                        backgroundColor: Colors.white,
                        textColor: kPrimaryColor,
                        borderColor: kPrimaryColor,
                        onPressed: widget.onBack,
                        text: 'Back',
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<CheckoutCubit, CheckoutState>(
                        builder: (context, state) {
                          if (state is ConfirmOrderSuccess) {
                            cubit.nextStep();
                          }
                          return CustomButton(
                            onPressed: () {
                              if (cubit.getLocationModel == null &&
                                  cubit.getLocationModel == null) {
                                return;
                              }
                              cubit.confirmOrder();
                            },
                            text: 'Deliver',
                          );
                        },
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

class LocationSection extends StatelessWidget {
  const LocationSection({super.key, required this.cubit});
  final CheckoutCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        LocationItem(
          location: 'Street1',
          value: cubit.getLocationModel?.street1,
        ),
        LocationItem(
          location: 'Street2',
          value: cubit.getLocationModel?.street2,
        ),
        LocationItem(location: 'City', value: cubit.getLocationModel?.city),
        LocationItem(
          location: 'Country',
          value: cubit.getLocationModel?.country,
        ),
        LocationItem(location: 'State', value: cubit.getLocationModel?.state),
      ],
    );
  }
}

class LocationItem extends StatelessWidget {
  const LocationItem({super.key, required this.location, required this.value});
  final String location;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Flexible(
        child: Row(
          children: [
            Flexible(
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 24,
                    color: kPrimaryColor,
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    text: '$location : ',
                    fontSize: 16,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
            Flexible(
              child: CustomText(
                text: value ?? 'Address not found',
                fontSize: 14,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
