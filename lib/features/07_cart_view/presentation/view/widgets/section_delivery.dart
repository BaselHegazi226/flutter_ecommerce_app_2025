import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/helper/date_formatter.dart';
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
  final ValueNotifier<int> valueNotifier = ValueNotifier<int>(1);
  final ValueNotifier<DeliveryMethodModel>
  deliveryNotifier = ValueNotifier<DeliveryMethodModel>(
    const DeliveryMethodModel(
      title: 'Next Day Delivery',
      subtitle:
          'Place your order before 6pm and your items will be delivered the next day',
    ),
  );

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // إرسال الطريقة الافتراضية عند البداية
    context.read<CheckoutCubit>().chooseDeliveryMethod(
      deliveryMethodModel: deliveryNotifier.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: ValueListenableBuilder<int>(
              valueListenable: valueNotifier,
              builder: (context, value, _) {
                return _buildRadioButtonsSections(context, value, cubit);
              },
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
                  // لو Nominated Delivery ومش مختار تاريخ
                  if (valueNotifier.value == 2 && selectedDate == null) {
                    selectedDate = DateTime.now();
                    final formattedDate = DateFormatter.format(
                      selectedDate!,
                      Localizations.localeOf(context).languageCode,
                    );
                    deliveryNotifier.value = DeliveryMethodModel(
                      title: S.of(context).cart_nominatedDelivery,
                      subtitle:
                          '${S.of(context).cartPickAParticularResult} $formattedDate',
                    );
                    cubit.chooseDeliveryMethod(
                      deliveryMethodModel: deliveryNotifier.value,
                    );
                  }
                  widget.onNext();
                },
                text: S.of(context).cart_next,
                textColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade600
                    : Colors.grey.shade200,
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade200
                    : Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildRadioButtonsSections(
    BuildContext context,
    int value,
    CheckoutCubit cubit,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Next Day Delivery
        RadioListTile(
          value: 1,
          groupValue: value,
          activeColor: theme.primaryColor,
          onChanged: (index) {
            changeValueNotifier(index!);
            selectedDate = null;

            deliveryNotifier.value = DeliveryMethodModel(
              title: S.of(context).cart_nextDayDelivery,
              subtitle: S.of(context).cart_placeYourOrder,
            );

            cubit.chooseDeliveryMethod(
              deliveryMethodModel: deliveryNotifier.value,
            );
          },
          title: CustomText(
            text: S.of(context).cart_nextDayDelivery,
            fontSize: 18,
          ),
          subtitle: CustomText(
            text: S.of(context).cart_placeYourOrder,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 32),

        // Nominated Delivery
        RadioListTile(
          value: 2,
          groupValue: value,
          activeColor: theme.primaryColor,
          onChanged: (index) async {
            changeValueNotifier(index!);

            deliveryNotifier.value = DeliveryMethodModel(
              title: S.of(context).cart_nominatedDelivery,
              subtitle: S.of(context).cart_pickAParticular,
            );

            cubit.chooseDeliveryMethod(
              deliveryMethodModel: deliveryNotifier.value,
            );

            // اختر التاريخ
            final pickedDate = await _showDeliveryDateBottomSheet(context);
            selectedDate = pickedDate ?? DateTime.now();

            // استخدم DateFormatter حسب لغة التطبيق
            final formattedDate = DateFormatter.format(
              selectedDate!,
              Localizations.localeOf(context).languageCode,
            );

            deliveryNotifier.value = DeliveryMethodModel(
              title: S.of(context).cart_nominatedDelivery,
              subtitle:
                  '${S.of(context).cartPickAParticularResult} $formattedDate',
            );

            cubit.chooseDeliveryMethod(
              deliveryMethodModel: deliveryNotifier.value,
            );
          },
          title: CustomText(
            text: S.of(context).cart_nominatedDelivery,
            fontSize: 18,
          ),
          subtitle: ValueListenableBuilder<DeliveryMethodModel>(
            valueListenable: deliveryNotifier,
            builder: (context, model, _) {
              return CustomText(
                text: model.title == S.of(context).cart_nominatedDelivery
                    ? model.subtitle
                    : S.of(context).cart_pickAParticular,
                fontSize: 14,
              );
            },
          ),
        ),

        const SizedBox(height: 32),

        // Standard Delivery
        RadioListTile(
          value: 3,
          groupValue: value,
          activeColor: theme.primaryColor,
          onChanged: (index) {
            changeValueNotifier(index!);
            selectedDate = null;

            deliveryNotifier.value = DeliveryMethodModel(
              title: S.of(context).cart_standardDelivery,
              subtitle: S.of(context).cart_orderWillBe,
            );

            cubit.chooseDeliveryMethod(
              deliveryMethodModel: deliveryNotifier.value,
            );
          },
          title: CustomText(
            text: S.of(context).cart_standardDelivery,
            fontSize: 18,
          ),
          subtitle: CustomText(
            text: S.of(context).cart_orderWillBe,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void changeValueNotifier(int index) {
    valueNotifier.value = index;
  }

  Future<DateTime?> _showDeliveryDateBottomSheet(BuildContext context) {
    DateTime tempDate = DateTime.now();

    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).calendarTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).brightness == Brightness.dark
                      ? ColorScheme.dark(
                          primary: Colors.grey.shade500,
                          onPrimary: Colors.white,
                        )
                      : const ColorScheme.light(
                          primary: kPrimaryColor,
                          onPrimary: Colors.white,
                        ),
                ),
                child: CalendarDatePicker(
                  initialDate: tempDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2026, 12, 31),
                  onDateChanged: (date) {
                    tempDate = date;
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      S.of(context).calendar_cancel,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, tempDate),
                    child: Text(S.of(context).calendar_confirm),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
