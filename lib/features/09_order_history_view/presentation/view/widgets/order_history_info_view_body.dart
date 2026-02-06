import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view_model/order_info_cubit/order_info_cubit.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_loading_indicator.dart';
import '../../../../../core/utilities/not_item_found.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import 'order_info_section.dart';

class OrderInfoViewBody extends StatelessWidget {
  const OrderInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderInfoCubit, OrderInfoState>(
      builder: (context, state) {
        if (state is GetOrderHistoryInfoSuccess) {
          final locationModel = state.orderInfoModel.locationModel;
          final phoneNumber = state.orderInfoModel.phoneNumber;
          if (locationModel!.street1.isEmpty) {
            return Center(
              child: NoItemFound(
                itemTitle: S.of(context).profileNoShippingAddress,
                itemImage: Assets.profileUnFavouriteHeart,
              ),
            );
          }
          return OrderInfoSection(
            locationModel: locationModel,
            phoneNumber: phoneNumber!,
          );
        } else if (state is GetOrderHistoryInfoFailure) {
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
