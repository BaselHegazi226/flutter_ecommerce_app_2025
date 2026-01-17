import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_snack_bar.dart';

import '../../../../../generated/l10n.dart';
import '../../../data/model/delivery_method_model.dart';
import '../../view_model/checkout_cubit/checkout_cubit.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  ValueNotifier<int> valueNotifier = ValueNotifier<int>(1);
  DeliveryMethodModel deliveryMethodModel = const DeliveryMethodModel(
    title: 'Next Day Delivery',
    subtitle:
        'Place your order before 12 hour and your items will be delivered the next day',
  );

  @override
  void initState() {
    super.initState();
    context.read<CheckoutCubit>().chooseDeliveryMethod(
      deliveryMethodModel: deliveryMethodModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: valueNotifier,
                    builder: (context, value, child) {
                      return _buildRadioButtonsSections(context, value, cubit);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    if (cubit.getDeliveryMethodModel != null) {
                      widget.onNext();
                    } else {
                      showSafeSnackBar(
                        context,
                        'choose any delivery method',
                        Colors.grey,
                      );
                    }
                  },
                  text: S.of(context).cart_next,
                  textColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade600
                      : Colors.grey.shade200,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade200
                      : Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildRadioButtonsSections(
    BuildContext context,
    int value,
    CheckoutCubit cubit,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
          value: 1,
          activeColor: Theme.of(context).primaryColor,
          groupValue: value,
          onChanged: (index) {
            changeValueNotifier(index!);
            deliveryMethodModel = const DeliveryMethodModel(
              title: 'Next Day Delivery',
              subtitle:
                  'Place your order before 12 hour and your items will be delivered the next day',
            );
            cubit.chooseDeliveryMethod(
              deliveryMethodModel: deliveryMethodModel,
            );
          },
          title: CustomText(
            text: S.of(context).cartNextDayDelivery,
            fontSize: 18,
          ),
          subtitle: CustomText(
            text: S.of(context).cartPlaceYourOrder,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 40),
        RadioListTile(
          value: 2,
          activeColor: Theme.of(context).primaryColor,
          groupValue: value,
          onChanged: (index) {
            changeValueNotifier(index!);
            deliveryMethodModel = const DeliveryMethodModel(
              title: 'Nominated Delivery',
              subtitle:
                  'Pick a particular date from the calendar and order will be delivered on selected date',
            );
            cubit.chooseDeliveryMethod(
              deliveryMethodModel: deliveryMethodModel,
            );
          },
          title: CustomText(
            text: S.of(context).cartNominatedDelivery,
            fontSize: 18,
          ),
          subtitle: CustomText(
            text: S.of(context).cartPickAParticular,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 40),
        RadioListTile(
          value: 3,
          activeColor: Theme.of(context).primaryColor,
          groupValue: value,
          onChanged: (index) {
            changeValueNotifier(index!);
            deliveryMethodModel = const DeliveryMethodModel(
              title: 'Standard Delivery',
              subtitle: 'Order will be delivered between 3 - 5 business days',
            );
            cubit.chooseDeliveryMethod(
              deliveryMethodModel: deliveryMethodModel,
            );
          },
          title: CustomText(
            text: S.of(context).cartStandardDelivery,
            fontSize: 18,
          ),
          subtitle: CustomText(
            text: S.of(context).cartStandardDelivery,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  changeValueNotifier(int index) {
    valueNotifier.value = index;
  }
}
