import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../../../../core/utilities/extensions_of_s_localization.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/model/onboarding_item_model.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key, required this.data});

  final OnboardingItemModel data; // نوع الداتا بتاعتك

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _skipSection(context),
          _imageSection(),
          const SizedBox(height: 16),
          _descSection(),
        ],
      ),
    );
  }

  Widget _skipSection(BuildContext context) {
    return Row(
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
    );
  }

  Widget _descSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        CustomText(
          text: data.title1,
          textAlign: TextAlign.center,
          fontSize: 24,
        ),
        CustomText(
          text: data.subTitle,
          textAlign: TextAlign.center,
          fontSize: 16,
        ),
      ],
    );
  }

  Widget _imageSection() {
    return AspectRatio(
      aspectRatio: 1.2,
      child: SvgPicture.asset(data.image, fit: BoxFit.contain),
    );
  }
}
