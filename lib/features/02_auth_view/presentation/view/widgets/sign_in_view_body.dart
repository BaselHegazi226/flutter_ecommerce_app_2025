import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_in_custom_social_buttons.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_in_email_password_input_section.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_in_header.dart';

import '../../../../../core/utilities/custom_card.dart';
import '../../../../../generated/l10n.dart';

class SignInViewViewBody extends StatelessWidget {
  const SignInViewViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const SizedBox(height: 48),
          const CustomCard(
            child: Column(
              children: [
                SignInHeader(),
                SizedBox(height: 50),
                SignInEmailPasswordInputSection(),
              ],
            ),
          ),
          const SizedBox(height: 4),
          CustomText(
            text: S.of(context).Or,
            fontSize: 18,
            alignment: Alignment.center,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: SignInCustomSocialButtons(),
          ),
        ],
      ),
    );
  }
}
