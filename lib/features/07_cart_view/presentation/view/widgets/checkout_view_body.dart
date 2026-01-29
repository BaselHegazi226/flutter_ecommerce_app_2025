import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
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
    final checkoutCubit = context.read<CheckoutCubit>();

    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is OrderReadyFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 24),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: buildEasyStepper(context, checkoutCubit, isDark, size),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: IndexedStack(
                    index: checkoutCubit.currentStep,
                    children: [
                      DeliveryView(onNext: checkoutCubit.nextStep),
                      LocationView(
                        onNext: checkoutCubit.nextStep,
                        onBack: checkoutCubit.previousStep,
                      ),
                      SummarizeView(
                        checkoutCubit: checkoutCubit,
                        onNext: checkoutCubit.nextStep,
                        onBack: checkoutCubit.previousStep,
                      ),
                      SectionPayment(
                        orderModel: checkoutCubit.orderModel,
                        onBack: checkoutCubit.previousStep,
                        onFinish: checkoutCubit.confirmOrder,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  EasyStepper buildEasyStepper(
    BuildContext context,
    CheckoutCubit cubit,
    bool isDark,
    Size size,
  ) {
    return EasyStepper(
      activeStep: cubit.currentStep,
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
      stepRadius: size.width > 700 ? 36 : 20,
      borderThickness: 2,

      // finished step
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

      // active step
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

      // unreached step
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
          title: S.of(context).cart_payment,
        ),
      ],
    );
  }
}
