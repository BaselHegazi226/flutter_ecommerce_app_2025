import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:go_router/go_router.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              text: 'Welcome,',
              fontSize: 30,
              alignment: Alignment.topLeft,
            ),
            CustomButton(
              paddingValue: 8,
              text: 'Sign Up',
              textColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade600
                  : Colors.grey.shade200,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade200
                  : kPrimaryColor,
              onPressed: () {
                GoRouter.of(context).push(Routes.registerView);
              },
            ),
          ],
        ),
        const CustomText(
          text: 'Sign in to continue',
          fontSize: 16,
          alignment: Alignment.topLeft,
          color: kGreyColor,
        ),
      ],
    );
  }
}
