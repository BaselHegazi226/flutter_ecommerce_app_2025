import 'package:flutter/material.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_circle_button.dart';

class OnBoardingViewButtonSection extends StatelessWidget {
  const OnBoardingViewButtonSection({
    super.key,
    required this.backOnPressed,
    required this.nextButtonOnPressed,
    required this.currentPage,
  });

  final VoidCallback backOnPressed, nextButtonOnPressed;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentPage > 0
            ? CustomCircleButton(
                onPressed: backOnPressed,
                iconData: Icons.arrow_back_outlined,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                borderColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade500.withAlpha(124)
                    : kPrimaryColor,
                iconColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade50
                    : kPrimaryColor,
              )
            : const SizedBox.shrink(),

        CustomCircleButton(
          onPressed: nextButtonOnPressed,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade500.withAlpha(124)
              : kPrimaryColor,
          iconColor: Colors.grey.shade50,
        ),
      ],
    );
  }
}
