import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/02_onboarding_view/presentation/view/widgets/onboarding_page_view_body.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: const OnboardingPageViewBody(),
      ),
    );
  }
}
