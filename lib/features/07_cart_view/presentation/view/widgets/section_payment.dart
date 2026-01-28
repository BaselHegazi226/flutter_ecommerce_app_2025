import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/price_button_section.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view/widgets/payment_web_view.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view/widgets/section_payment_track_item.dart';

import '../../../../../generated/l10n.dart';
import '../../../data/model/order_model.dart';
import '../../view_model/cart_bloc/cart_bloc.dart';
import '../../view_model/checkout_cubit/checkout_cubit.dart';
import '../../view_model/payment_bloc/payment_bloc.dart';

class SectionPayment extends StatelessWidget {
  const SectionPayment({
    super.key,
    required this.orderModel,
    required this.onBack,
    required this.onFinish,
  });

  final OrderModel? orderModel;
  final VoidCallback onBack;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final updatedOrder = state is OrderModelCreatedSuccess
            ? state.order
            : orderModel;

        if (updatedOrder == null) {
          return const Center(
            child: CustomText(
              text: 'Order Data Not Found',
              fontSize: 18,
              color: kPrimaryWrongColor,
            ),
          );
        }

        return buildSuccessState(context, updatedOrder);
      },
    );
  }

  Widget buildSuccessState(BuildContext context, OrderModel updatedOrder) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  checkCircleSection(context),
                  const SizedBox(height: 16),
                  dateStateSection(updatedOrder, context),
                  const SizedBox(height: 8),
                  SectionPaymentTrackItem(orderModel: updatedOrder),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        // سكشن السعر ثابت
        buildBlocConsumer(),
      ],
    );
  }

  Column dateStateSection(OrderModel updatedOrder, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              'OD-${orderModel!.orderId.split('-').take(2).join('-')}-N',
              minFontSize: 8,
              style: const TextStyle(fontSize: 12),
              maxFontSize: 16,
              maxLines: 1,
            ),
            TextButton(
              onPressed: onBack,
              child: Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.blueGrey.shade200
                        : Colors.deepOrange,
                    size: 20,
                  ),
                  CustomText(
                    text: S.of(context).changeOrder,
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.blueGrey.shade200
                        : Colors.deepOrange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row checkCircleSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: S.of(context).orderReady,
          fontSize: 16,
          alignment: Alignment.center,
          fontWeight: FontWeight.bold,
        ),
        Icon(
          Icons.check_circle,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade200
              : kPrimaryColor,
        ),
      ],
    );
  }

  BlocConsumer<PaymentBloc, PaymentState> buildBlocConsumer() {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is ImplementPaymentWithPayMobSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PaymentWebView(
                url: state.successUrl,
                onResult: (result) {
                  context.read<PaymentBloc>().add(
                    GetPaymentStateEvent(paymentState: result),
                  );
                },
              ),
            ),
          );
        } else if (state is GetPaMobPaymentStateSuccess) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // اقفل WebView
          }
          //trigger delete product from cart after add order
          context.read<CartBloc>().add(DeleteAllProductsEvent());

          onFinish();
        } else if (state is GetPaMobPaymentStateFailure) {
          Navigator.pop(context); // اقفل WebView
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return buildPriceButtonSection(context, state);
      },
    );
  }

  PriceButtonSection buildPriceButtonSection(
    BuildContext context,
    PaymentState state,
  ) {
    return PriceButtonSection(
      title: S.of(context).cartTotal,
      value: '${priceShowed(orderModel!.totalPrice)} ${S.of(context).EP}',
      widget: CustomTextIconButton(
        isLoading: state is ImplementPaymentWithPayMobLoading,
        onPressed: () {
          context.read<PaymentBloc>().add(
            ImplementPaymentWithPayMobEvent(orderModel: orderModel!),
          );
        },
        text: S.of(context).cartPayment,
        textColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade600
            : Colors.grey.shade200,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade200
            : kPrimaryColor,
        iconData: Icons.payment_outlined,
      ),
    );
  }
}
