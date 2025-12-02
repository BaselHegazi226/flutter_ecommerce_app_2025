import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/delivery_view.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/location_view.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view/widgets/summarize_view.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/checkout_cubit/checkout_cubit.dart';

import '../../../../../generated/l10n.dart';
import 'finish_view.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            top: 24,
            right: 16,
            left: 16,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(child: buildEasyStepper(cubit, context)),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverFillRemaining(
                hasScrollBody: false,
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
                    FinishView(
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

  EasyStepper buildEasyStepper(CheckoutCubit cubit, BuildContext context) {
    return EasyStepper(
      activeStep: cubit.getCurrentStep,
      stepShape: StepShape.circle,
      lineStyle: const LineStyle(lineLength: 50),
      stepRadius: 28,
      borderThickness: 2,
      finishedStepBorderColor: Colors.grey.shade900,
      finishedStepTextColor: Colors.grey.shade900,
      finishedStepBackgroundColor:
          Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade500.withAlpha(32)
          : Colors.white,
      finishedStepIconColor: Colors.grey.shade900,
      activeStepBackgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade500.withAlpha(32)
          : Colors.white,
      activeStepBorderColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade200
          : kPrimaryColor,
      activeStepTextColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade200
          : kPrimaryColor,
      activeStepIconColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade200
          : kPrimaryColor,
      unreachedStepBackgroundColor:
          Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade500.withAlpha(32)
          : Colors.white,
      unreachedStepTextColor: Colors.grey,
      unreachedStepIconColor: Colors.grey,
      unreachedStepBorderColor: Colors.grey,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          icon: const Icon(Icons.delivery_dining),
          title: S.of(context).Delivery,
        ),
        EasyStep(
          icon: const Icon(Icons.location_on_outlined),
          title: S.of(context).Location,
        ),
        EasyStep(
          icon: const Icon(Icons.note_alt_outlined),
          title: S.of(context).Summarize,
        ),
        EasyStep(
          icon: const Icon(Icons.check_circle_outline),
          title: S.of(context).Finish,
        ),
      ],
      // onStepReached: (index) {
      //   setState(() => activeStep = index);
      // },
    );
  }
}
