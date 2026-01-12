import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/helper/extensions_of_s_localization.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/model/onboarding_item_model.dart';
import 'onboarding_view_description_section.dart';
import 'onboarding_view_image_section.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key, required this.data});

  final OnboardingItemModel data; // نوع الداتا بتاعتك

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go(Routes.loginView);
                },
                child: CustomText(
                  text: S.of(context).onBoardingSkip,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kGreyColor,
                ),
              ),
            ],
          ),

          OnBoardingViewImageSection(image: data.image),
          const SizedBox(height: 48),

          OnBoardingViewDescriptionSection(
            title1: data.title1,
            subTitle: data.subTitle,
          ),
        ],
      ),
    );
  }
}
