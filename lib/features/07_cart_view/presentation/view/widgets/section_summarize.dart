import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_order_list.dart';

import '../../../../../core/helper/date_formatter.dart';
import '../../../../../core/utilities/custom_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/model/delivery_method_model.dart';
import '../../view_model/checkout_cubit/checkout_cubit.dart';
import '../../view_model/get_cart_cubit/get_cart_cubit.dart';
import '../../view_model/get_cart_cubit/get_cart_state.dart';

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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowOrderList(carts: carts),
                      const SizedBox(height: 16),
                      Container(
                        height: 1,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade50
                            : Colors.black26,
                      ),
                      const SizedBox(height: 16),
                      CustomText(
                        text: _buildDeliverySummaryText(
                          context,
                          cubit.getDeliveryMethodModel!,
                        ),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              '${S.of(context).formStreet1}: ${cubit.getLocationModel?.street1}\n'
                              '${S.of(context).formStreet2}: ${cubit.getLocationModel?.street2}\n'
                              '${S.of(context).formCity}: ${cubit.getLocationModel?.city}\n'
                              '${S.of(context).formState}: ${cubit.getLocationModel?.state}\n'
                              '${S.of(context).formCountry}: ${cubit.getLocationModel?.country}',
                              softWrap: true,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.check_circle,
                            color:
                                Theme.of(context).brightness == Brightness.dark
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
                            text: S.of(context).cartTotal,
                            fontSize: 18,
                            alignment: Alignment.centerLeft,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text:
                                '${priceShowed(totalPrice)} ${S.of(context).EP}',
                            fontSize: 16,
                            alignment: Alignment.centerLeft,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade200
                                : kPrimaryColor,
                          ),
                        ],
                      ),
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
                        textColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade200
                            : kPrimaryColor,
                        onPressed: widget.onBack,
                        text: S.of(context).cart_back,
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
                        },
                        text: S.of(context).cartDelivery,
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
            ],
          );
        } else {
          return const CustomCircleIndicator(color: kPrimaryColor);
        }
      },
    );
  }

  String _buildDeliverySummaryText(
    BuildContext context,
    DeliveryMethodModel model,
  ) {
    final subtitle = model.subtitle.trim();
    final locale = Localizations.localeOf(context).languageCode; // 'ar' أو 'en'

    // لو فيه تاريخ مختار (Nominated Delivery)
    if (model.title.contains(S.of(context).cartNominatedDelivery)) {
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
}
