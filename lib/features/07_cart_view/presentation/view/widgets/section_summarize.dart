import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/navigate_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_order_list.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/data/model/order_model.dart';

import '../../../../../core/helper/date_formatter.dart';
import '../../../../../core/utilities/total_price_section.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/model/delivery_method_model.dart';
import '../../view_model/checkout_cubit/checkout_cubit.dart';

class SummarizeView extends StatefulWidget {
  const SummarizeView({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.checkoutCubit,
  });

  final VoidCallback onNext, onBack;
  final CheckoutCubit checkoutCubit;

  @override
  State<SummarizeView> createState() => _SummarizeViewState();
}

class _SummarizeViewState extends State<SummarizeView> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          final orderModel = widget.checkoutCubit.orderModel;

          if (state is OrderModelCreatedSuccess) {
            return _buildSuccessStateWidget(
              context,
              size,
              orderModel: state.order,
              cubit: cubit,
            );
          }

          if (orderModel != null) {
            return _buildSuccessStateWidget(
              context,
              size,
              orderModel: orderModel,
              cubit: cubit,
            );
          }

          if (state is OrderReadyFailure) {
            return Center(
              child: CustomText(text: state.errorMessage, fontSize: 18),
            );
          }

          return const CustomCircleIndicator();
        },
      ),
    );
  }

  Column _buildSuccessStateWidget(
    BuildContext context,
    Size size, {
    required CheckoutCubit cubit,
    required OrderModel orderModel,
  }) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _summarizeItem(
                  ShowOrderList(carts: orderModel.cartModelList),
                  S.of(context).orderProductList,
                  Icons.shopping_cart_rounded,
                ),
                const SizedBox(height: 16),
                _summarizeItem(
                  CustomText(
                    text: _buildDeliverySummaryText(
                      context,
                      cubit.getDeliveryMethod!,
                    ),
                    fontSize: 12,
                  ),
                  S.of(context).orderDeliveryTime,
                  Icons.access_time_outlined,
                ),
                const SizedBox(height: 16),
                _summarizeItem(
                  CustomText(
                    text: orderModel.orderInfoModel.phoneNumber!,
                    fontSize: 12,
                  ),
                  S.of(context).phoneNumber,
                  Icons.phone_outlined,
                ),
                const SizedBox(height: 16),
                _summarizeItem(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          text:
                              '${S.of(context).formStreet1}: ${orderModel.orderInfoModel.locationModel!.street1}\n'
                              '${S.of(context).formStreet2}: ${orderModel.orderInfoModel.locationModel!.street2}\n'
                              '${S.of(context).formCity}: ${orderModel.orderInfoModel.locationModel!.city}\n'
                              '${S.of(context).formState}: ${orderModel.orderInfoModel.locationModel!.state}\n'
                              '${S.of(context).formCountry}: ${orderModel.orderInfoModel.locationModel!.country}',
                          fontSize: 12,
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
                  S.of(context).orderAddress,
                  Icons.location_on_outlined,
                ),
                const SizedBox(height: 16),
                TotalPriceSection(total: orderModel.totalPrice),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            spacing: 16,
            children: [
              SizedBox(
                width: size.width * .3,
                child: NavigateButton(
                  isBack: true,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade700
                      : kScaffoldColor,
                  borderColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryColor,
                  textColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade200
                      : kPrimaryColor,
                  onPressed: widget.onBack,
                  text: S.of(context).cart_back,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: size.width * .3,
                child: NavigateButton(
                  onPressed: () {
                    widget.onNext();
                  },
                  text: S.of(context).cart_next,
                  textColor: Theme.of(context).brightness == Brightness.dark
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
      ],
    );
  }

  String _buildDeliverySummaryText(
    BuildContext context,
    DeliveryMethodModel model,
  ) {
    final subtitle = model.subtitle(context);
    final locale = Localizations.localeOf(context).languageCode; // 'ar' أو 'en'

    // لو فيه تاريخ مختار (Nominated Delivery)
    if (model.title(context).contains(S.of(context).cartNominatedDelivery)) {
      // استخراج التاريخ من النص
      final dateMatch = RegExp(r'\d{4}-\d{2}-\d{2}').firstMatch(subtitle);
      if (dateMatch != null) {
        final date = DateTime.parse(dateMatch.group(0)!);
        final formattedDate = DateFormatter.format(date, locale);
        return '${S.of(context).cartPickAParticularResult} $formattedDate';
      }

      return subtitle;
    }

    // الحالات العادية
    if (subtitle.contains(S.of(context).cartPlaceYourOrder)) {
      return S.of(context).cartPlaceYourResult;
    } else if (subtitle.contains(S.of(context).cartPickAParticular)) {
      return S.of(context).cartPickAParticularResult;
    } else {
      return S.of(context).cartOrderWillBeResult;
    }
  }

  Widget _summarizeItem(Widget widget, String title, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 6,
          children: [
            Icon(iconData, size: 16),
            CustomText(
              text: '$title :',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : Colors.black87,
            ),
          ],
        ),
        const SizedBox(height: 16),
        widget,
        const SizedBox(height: 8),
        Container(
          height: 1,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade50
              : Colors.black26,
        ),
      ],
    );
  }
}
