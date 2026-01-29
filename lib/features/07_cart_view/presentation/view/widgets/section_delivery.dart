import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/extensions_of_s_localization.dart';
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

  final ValueNotifier<DeliveryMethodModel> deliveryNotifier =
      ValueNotifier<DeliveryMethodModel>(
        const DeliveryMethodModel(deliveryType: DeliveryType.standard),
      );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<CheckoutCubit>();
      final currentDelivery =
          cubit.getDeliveryMethod ??
          const DeliveryMethodModel(deliveryType: DeliveryType.standard);

      deliveryNotifier.value = currentDelivery;
      valueNotifier.value = _indexFromType(currentDelivery.deliveryType);

      // send initial value if null
      if (cubit.getDeliveryMethod == null) {
        cubit.chooseDeliveryMethod(deliveryMethodModel: currentDelivery);
      }
    });
  }

  int _indexFromType(DeliveryType type) {
    switch (type) {
      case DeliveryType.standard:
        return 1;
      case DeliveryType.nextDay:
        return 2;
      case DeliveryType.nominated:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: valueNotifier,
              builder: (_, value, __) {
                return _buildRadios(context, value, isDark);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: size.width * .3,
                child: CustomButton(
                  text: S.of(context).cart_next,
                  onPressed: widget.onNext,
                  textColor: isDark
                      ? Colors.grey.shade600
                      : Colors.grey.shade200,
                  backgroundColor: isDark
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

  Column _buildRadios(BuildContext context, int value, bool isDark) {
    return Column(
      children: [
        _radioTile(
          index: 1,
          current: value,
          model: const DeliveryMethodModel(deliveryType: DeliveryType.standard),

          onTap: () => _updateDelivery(1, DeliveryType.standard),
        ),
        const SizedBox(height: 24),
        _radioTile(
          index: 2,
          current: value,
          model: const DeliveryMethodModel(deliveryType: DeliveryType.nextDay),
          onTap: () => _updateDelivery(2, DeliveryType.nextDay),
        ),
        const SizedBox(height: 24),
        ValueListenableBuilder<DeliveryMethodModel>(
          valueListenable: deliveryNotifier,
          builder: (_, model, __) {
            final displayModel = model.deliveryType == DeliveryType.nominated
                ? model
                : const DeliveryMethodModel(
                    deliveryType: DeliveryType.nominated,
                  );

            return _radioTile(
              index: 3,
              current: value,
              model: displayModel,

              onTap: () async {
                valueNotifier.value = 3;
                final checkoutCubit = context.read<CheckoutCubit>();
                final date = await _showDatePicker(context);
                final selected = date ?? DateTime.now();
                final newModel = DeliveryMethodModel(
                  deliveryType: DeliveryType.nominated,
                  selectedTime: selected,
                );
                deliveryNotifier.value = newModel;
                checkoutCubit.chooseDeliveryMethod(
                  deliveryMethodModel: newModel,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _radioTile({
    required int index,
    required int current,
    required DeliveryMethodModel model,
    required VoidCallback onTap,
  }) {
    return RadioListTile<int>(
      value: index,
      groupValue: current,
      onChanged: (_) => onTap(),
      activeColor: Theme.of(context).primaryColor,
      title: CustomText(
        text: model.title(context),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      subtitle: CustomText(text: model.subtitle(context), fontSize: 14),
    );
  }

  void _updateDelivery(int index, DeliveryType type) {
    valueNotifier.value = index;

    final model = DeliveryMethodModel(deliveryType: type);

    deliveryNotifier.value = model;

    context.read<CheckoutCubit>().chooseDeliveryMethod(
      deliveryMethodModel: model,
    );
  }

  Future<DateTime?> _showDatePicker(BuildContext context) {
    DateTime focusedDay = DateTime.now();
    DateTime? selectedDay;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.grey.withAlpha(32),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    S.of(context).calendarTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Calendar
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1, // يمنع تكبير النص من إعدادات الجهاز
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime(2026, 12, 31),
                      focusedDay: focusedDay,

                      rowHeight: 36,

                      // خليتها متناسقة مع النص
                      selectedDayPredicate: (day) {
                        return selectedDay != null &&
                            isSameDay(selectedDay, day);
                      },

                      onDaySelected: (selected, focused) {
                        setState(() {
                          selectedDay = selected;
                          focusedDay = focused;
                        });

                        Navigator.pop(context, selected);
                      },

                      sixWeekMonthsEnforced: true,

                      /// Header
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),

                      /// أيام الأسبوع
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700,
                        ),
                      ),

                      /// شكل الأيام
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,

                        /// كل النصوص نفس الحجم
                        defaultTextStyle: const TextStyle(fontSize: 12),
                        weekendTextStyle: const TextStyle(fontSize: 12),
                        selectedTextStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        todayTextStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        disabledTextStyle: const TextStyle(fontSize: 11),

                        /// اليوم الحالي
                        todayDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark ? Colors.grey.shade500 : kPrimaryColor,
                        ),

                        /// اليوم المختار
                        selectedDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark ? Colors.grey.shade500 : kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
