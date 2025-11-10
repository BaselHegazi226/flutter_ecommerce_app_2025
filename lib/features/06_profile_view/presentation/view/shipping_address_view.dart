import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/order_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/not_item_found.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_state.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/shipping_address_location.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/const.dart';
import '../../../../generated/assets.dart';

class ShippingAddressView extends StatelessWidget {
  const ShippingAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderCubit(orderCache: AppGet().getIt<OrderCacheImplement>())
            ..getUserLocation(),
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(context, 'Shipping Address', () {
            GoRouter.of(context).pushReplacement(Routes.profileView);
          }),
          body: const Padding(
            padding: EdgeInsets.all(16),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: ShippingAddressViewBody(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShippingAddressViewBody extends StatelessWidget {
  const ShippingAddressViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is GetUserLocationSuccess) {
          final locationModel = state.locationModel;
          if (locationModel.street1.isEmpty) {
            return const NoItemFound(
              itemTitle: 'No Location Found try make order!',
              itemImage: Assets.profileNoLocation,
            );
          }
          return Column(
            children: [
              const Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 8),
                  CustomText(
                    text: 'Location',
                    fontSize: 18,
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LocationSection(locationModel: locationModel),
            ],
          );
        } else if (state is GetUserLocationFailure) {
          return const NoItemFound(
            itemTitle: 'No Location Found try make order!',
            itemImage: Assets.profileNoLocation,
          );
        } else {
          return const CustomCircleIndicator(color: kPrimaryColor);
        }
      },
    );
  }
}
