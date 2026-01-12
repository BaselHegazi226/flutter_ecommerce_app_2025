import 'package:flutter/material.dart';

import 'onboarding_indicator.dart';

class OnboardingIndicatorSection extends StatelessWidget {
  const OnboardingIndicatorSection({super.key, required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return OnboardingIndicator(isActive: currentPage == index);
      }),
    );
  }
}
