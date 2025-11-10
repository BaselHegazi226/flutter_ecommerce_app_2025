import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_in_custom_social_buttons.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_in_email_password_input_section.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_in_header.dart';

import '../../../../../core/utilities/custom_card.dart';

class SignInViewViewBody extends StatelessWidget {
  const SignInViewViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(height: 48),
          CustomCard(
            child: Column(
              children: [
                SignInHeader(),
                SizedBox(height: 50),
                SignInEmailPasswordInputSection(),
              ],
            ),
          ),
          SizedBox(height: 4),
          CustomText(text: '_OR_', fontSize: 18, alignment: Alignment.center),
          Padding(
            padding: EdgeInsets.all(16),
            child: SignInCustomSocialButtons(),
          ),
        ],
      ),
    );
  }
}
