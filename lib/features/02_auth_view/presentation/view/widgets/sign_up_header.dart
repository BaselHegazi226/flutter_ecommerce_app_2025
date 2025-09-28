import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_button.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Welcome,',
              fontSize: 30,
              alignment: Alignment.topLeft,
            ),
            CustomButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              paddingValue: 8,
              text: 'Sign in',
              textColor: kPrimaryColor,
              backgroundColor: Colors.white,
            ),
          ],
        ),
        CustomText(
          text: 'Sign up to continue',
          fontSize: 16,
          alignment: Alignment.topLeft,
          color: kGreyColor,
        ),
      ],
    );
  }
}
