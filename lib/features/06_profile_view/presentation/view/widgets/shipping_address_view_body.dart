import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/not_item_found.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_state.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/shipping_address_location.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';

class ShippingAddressViewBody extends StatelessWidget {
  const ShippingAddressViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is GetUserLocationSuccess) {
          final locationModel = state.locationModel;
          if (locationModel.street1.isEmpty) {
            return Center(
              child: NoItemFound(
                itemTitle: S.of(context).profileNoShippingAddress,
                itemImage: Assets.profileUnFavouriteHeart,
              ),
            );
          }
          return Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 8),
                  CustomText(
                    text: S.of(context).profileShippingAddress,
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
          return Center(
            child: NoItemFound(
              itemTitle: S.of(context).orderNoLocation,
              itemImage: Assets.profileNoLocation,
            ),
          );
        } else {
          return const CustomCircleIndicator(color: kPrimaryColor);
        }
      },
    );
  }
}
