import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/03_auth_view/presentation/view/widgets/register_header.dart';
import 'package:flutter_e_commerce_app_2025/features/03_auth_view/presentation/view/widgets/register_input_section.dart';

import '../../../../../core/utilities/custom_card.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CustomCard(
            child: Column(
              children: [
                SizedBox(height: 48),
                RegisterHeader(),
                SizedBox(height: 50),
                RegisterInputSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
