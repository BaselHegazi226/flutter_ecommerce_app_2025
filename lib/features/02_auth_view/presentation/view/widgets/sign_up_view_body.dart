import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_up_header.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_up_input_section.dart';

import '../../../../../core/utilities/custom_card.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CustomCard(
            child: Column(
              children: [
                SignUpHeader(),
                SizedBox(height: 50),
                SignUpInputSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
