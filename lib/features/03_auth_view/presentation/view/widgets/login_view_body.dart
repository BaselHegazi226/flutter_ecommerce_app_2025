import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

import '../../../../../core/utilities/custom_card.dart';
import '../../../../../generated/l10n.dart';
import 'login_custom_social_buttons.dart';
import 'login_email_password_input_section.dart';
import 'login_header.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

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
                LoginHeader(),
                SizedBox(height: 50),
                LoginEmailPasswordInputSection(),
              ],
            ),
          ),
          const SizedBox(height: 4),
          CustomText(
            text: S.of(context).authOr,
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
