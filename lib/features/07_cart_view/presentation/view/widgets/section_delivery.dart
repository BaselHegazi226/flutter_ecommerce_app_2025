import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/navigate_button.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_button.dart';
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
                child: NavigateButton(
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
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      subtitle: CustomText(text: model.subtitle(context), fontSize: 12),
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
    final ValueNotifier<DateTime?> selectedDayNotifier = ValueNotifier(null);
    final ValueNotifier<DateTime> focusedDayNotifier = ValueNotifier(
      DateTime.now(),
    );

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      barrierColor: Colors.grey.withAlpha(32),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (_, controller) {
              return Column(
                children: [
                  //content of calender
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title
                          Text(
                            S.of(context).calendarTitle,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),

                          /// Calendar
                          ValueListenableBuilder<DateTime?>(
                            valueListenable: selectedDayNotifier,
                            builder: (_, selectedDay, __) {
                              return ValueListenableBuilder<DateTime>(
                                valueListenable: focusedDayNotifier,
                                builder: (_, focusedDay, __) {
                                  return TableCalendar(
                                    firstDay: DateTime.now(),
                                    lastDay: DateTime(2026, 12, 31),
                                    focusedDay: focusedDay,

                                    /// 👇 Responsive height فقط
                                    rowHeight: height < 700 ? 48 : 60,

                                    selectedDayPredicate: (day) =>
                                        selectedDay != null &&
                                        isSameDay(selectedDay, day),

                                    onDaySelected: (selected, focused) {
                                      selectedDayNotifier.value = selected;
                                      focusedDayNotifier.value = focused;
                                    },

                                    sixWeekMonthsEnforced: true,

                                    /// Header (نفس ستايلك)
                                    headerStyle: HeaderStyle(
                                      titleCentered: true,
                                      formatButtonVisible: false,
                                      titleTextStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      leftChevronIcon: Icon(
                                        Icons.chevron_left,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      rightChevronIcon: Icon(
                                        Icons.chevron_right,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),

                                    /// Days of week
                                    daysOfWeekStyle: DaysOfWeekStyle(
                                      weekdayStyle: TextStyle(
                                        fontSize: width > 700 ? 12 : 8,
                                        color: isDark
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade700,
                                        height: 1.4,
                                      ),
                                      weekendStyle: TextStyle(
                                        fontSize: width > 700 ? 12 : 8,
                                        color: isDark
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade700,
                                        height: 1.4,
                                      ),
                                    ),

                                    /// Calendar Style (نفسك حرفيًا)
                                    calendarStyle: CalendarStyle(
                                      outsideDaysVisible: false,
                                      defaultTextStyle: const TextStyle(
                                        fontSize: 11,
                                        height: 1.4,
                                      ),
                                      weekendTextStyle: const TextStyle(
                                        fontSize: 11,
                                        height: 1.4,
                                      ),
                                      selectedTextStyle: TextStyle(
                                        fontSize: 11,
                                        color: isDark
                                            ? Colors.black54
                                            : Colors.white,
                                      ),
                                      todayTextStyle: TextStyle(
                                        fontSize: 11,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.black54,
                                      ),
                                      disabledTextStyle: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade500,
                                      ),

                                      todayDecoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor,
                                        border: Border.all(
                                          color: isDark
                                              ? Colors.grey.shade500
                                              : Colors.black54,
                                          width: 1.5,
                                        ),
                                      ),
                                      selectedDecoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isDark
                                            ? Colors.white
                                            : kPrimaryColor,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  //buttons
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20 + MediaQuery.of(context).padding.bottom,
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () => Navigator.pop(context, null),
                            backgroundColor: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                            borderColor: isDark ? Colors.white : Colors.black54,
                            textColor: isDark ? Colors.white : Colors.black54,
                            text: S.of(context).calendarCancel,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              Navigator.pop(context, selectedDayNotifier.value);
                            },
                            backgroundColor: isDark
                                ? Colors.grey.shade100
                                : kPrimaryColor,
                            borderColor: Colors.transparent,
                            textColor: isDark ? Colors.black54 : Colors.white,
                            text: S.of(context).calendarConfirm,
                          ),
                        ),
                      ],
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
