import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view/widgets/section_delivery.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view/widgets/section_location.dart';
import 'package:flutter_e_commerce_app_2025/features/07_cart_view/presentation/view/widgets/section_summarize.dart';

import '../../../../../generated/l10n.dart';
import '../../view_model/checkout_cubit/checkout_cubit.dart';
import 'section_payment.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 24),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  child: buildEasyStepper(cubit, context, isDark, size),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverFillRemaining(
                hasScrollBody: true,
                child: IndexedStack(
                  index: cubit.getCurrentStep,
                  children: [
                    DeliveryView(onNext: cubit.nextStep),
                    LocationView(
                      onNext: cubit.nextStep,
                      onBack: cubit.previousStep,
                    ),
                    SummarizeView(
                      onNext: () {
                        cubit.orderReady();
                        cubit.nextStep();
                      },
                      onBack: cubit.previousStep,
                    ),
                    SectionPayment(
                      orderModel: cubit.getOrderModel,
                      onBack: cubit.previousStep,
                      onFinish: cubit.confirmOrder, // هنا المهم
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  EasyStepper buildEasyStepper(
    CheckoutCubit cubit,
    BuildContext context,
    bool isDark,
    Size size,
  ) {
    return EasyStepper(
      activeStep: cubit.getCurrentStep,
      stepShape: StepShape.circle,
      lineStyle: LineStyle(
        lineLength: 50,
        lineType: LineType.dashed,
        defaultLineColor: Colors.transparent,
        activeLineColor: isDark ? Colors.grey.shade200 : kPrimaryColor,
        finishedLineColor: isDark
            ? Colors.grey.shade400
            : kPrimaryColor.withAlpha(125),
      ),
      stepRadius: size.width > 700 ? 52 : 28,
      borderThickness: 2,
      //finished step
      finishedStepBorderColor: isDark
          ? kCheckoutStepperFinishedColorDark
          : kCheckoutStepperFinishedColorLight,
      finishedStepTextColor: isDark
          ? kCheckoutStepperFinishedColorDark
          : kCheckoutStepperFinishedColorLight,
      finishedStepBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      finishedStepIconColor: isDark
          ? kCheckoutStepperFinishedColorDark
          : kCheckoutStepperFinishedColorLight,
      //active step
      activeStepBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      activeStepBorderColor: isDark
          ? kCheckoutStepperActiveColorDark
          : kCheckoutStepperActiveColorLight,
      activeStepTextColor: isDark
          ? kCheckoutStepperActiveColorDark
          : kCheckoutStepperActiveColorLight,
      activeStepIconColor: isDark
          ? kCheckoutStepperActiveColorDark
          : kCheckoutStepperActiveColorLight,
      //unreached step
      unreachedStepBorderColor: isDark
          ? kCheckoutStepperUnreachedColorDark
          : kCheckoutStepperUnreachedColorLight,
      unreachedStepIconColor: isDark
          ? kCheckoutStepperUnreachedColorDark
          : kCheckoutStepperUnreachedColorLight,
      unreachedStepTextColor: isDark
          ? kCheckoutStepperUnreachedColorDark
          : kCheckoutStepperUnreachedColorLight,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          icon: const Icon(Icons.delivery_dining),
          title: S.of(context).cartDelivery,
        ),
        EasyStep(
          icon: const Icon(Icons.location_on_outlined),
          title: S.of(context).cartLocation,
        ),
        EasyStep(
          icon: const Icon(Icons.note_alt_outlined),
          title: S.of(context).cartSummarize,
        ),
        EasyStep(
          icon: const Icon(Icons.credit_card),
          title: S.of(context).cartFinish,
        ),
      ],
      // onStepReached: (index) {
      //   setState(() => activeStep = index);
      // },
    );
  }
}
