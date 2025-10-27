import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_snack_bar.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/checkout_cubit/checkout_cubit.dart';

import '../../../data/model/delivery_method_model.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  ValueNotifier<int> valueNotifier = ValueNotifier<int>(1);
  late DeliveryMethodModel deliveryMethodModel;

  @override
  void initState() {
    super.initState();
    deliveryMethodModel = const DeliveryMethodModel(
      title: 'Next Day Delivery',
      subtitle:
          'Place your order before 6pm and your items will be delivered the next day',
    );
    context.read<CheckoutCubit>().chooseDeliveryMethod(
      deliveryMethodModel: deliveryMethodModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, value, child) {
            return Column(
              children: [
                RadioListTile(
                  value: 1,
                  activeColor: Colors.green,
                  groupValue: value,
                  onChanged: (index) {
                    changeValueNotifier(index!);
                    setState(() {});
                    cubit.chooseDeliveryMethod(
                      deliveryMethodModel: deliveryMethodModel,
                    );
                  },
                  title: const CustomText(
                    text: 'Next Day Delivery',
                    fontSize: 18,
                    alignment: Alignment.centerLeft,
                  ),
                  subtitle: const CustomText(
                    text:
                        'Place your order before 6pm and your items will be delivered the next day',
                    fontSize: 14,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                const SizedBox(height: 40),
                RadioListTile(
                  value: 2,
                  activeColor: Colors.green,
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
                  title: const CustomText(
                    text: 'Nominated Delivery',
                    fontSize: 18,
                    alignment: Alignment.centerLeft,
                  ),
                  subtitle: const CustomText(
                    text:
                        'Pick a particular date from the calendar and order will be delivered on selected date',
                    fontSize: 14,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                const SizedBox(height: 40),
                RadioListTile(
                  value: 3,
                  activeColor: Colors.green,
                  groupValue: value,
                  onChanged: (index) {
                    changeValueNotifier(index!);
                    deliveryMethodModel = const DeliveryMethodModel(
                      title: 'Standard Delivery',
                      subtitle:
                          'Order will be delivered between 3 - 5 business days',
                    );
                    cubit.chooseDeliveryMethod(
                      deliveryMethodModel: deliveryMethodModel,
                    );
                  },
                  title: const CustomText(
                    text: 'Standard Delivery',
                    fontSize: 18,
                    alignment: Alignment.centerLeft,
                  ),
                  subtitle: const CustomText(
                    text: 'Order will be delivered between 3 - 5 business days',
                    fontSize: 14,
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            );
          },
        ),
        const Expanded(child: SizedBox()),
        Align(
          alignment: AlignmentGeometry.bottomRight,
          child: Row(
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    if (cubit.getDeliveryMethodModel != null) {
                      widget.onNext();
                      debugPrint('go to location');
                    } else {
                      showSafeSnackBar(
                        context,
                        'choose any delivery method',
                        Colors.grey,
                      );
                    }
                  },
                  text: 'Next',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  changeValueNotifier(int index) {
    valueNotifier.value = index;
  }
}
