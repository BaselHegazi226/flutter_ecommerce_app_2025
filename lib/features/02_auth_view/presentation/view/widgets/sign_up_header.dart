import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_button.dart';
import '../../../../../generated/l10n.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: S.of(context).Welcome,
              fontSize: 30,
              alignment: Alignment.topLeft,
            ),
            CustomButton(
              paddingValue: 8,
              text: S.of(context).SignIn,
              textColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade600
                  : Colors.grey.shade200,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade200
                  : kPrimaryColor,
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ],
        ),
        CustomText(
          text: S.of(context).SignIntoContinue,
          fontSize: 16,
          color: kGreyColor,
        ),
      ],
    );
  }
}
