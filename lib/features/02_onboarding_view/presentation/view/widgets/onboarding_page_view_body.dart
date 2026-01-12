import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:go_router/go_router.dart';

import 'on_boarding_content_section.dart';
import 'onboarding_const_class.dart';
import 'onboarding_indicator_section.dart';
import 'onboarding_view_button_section.dart';

class OnboardingPageViewBody extends StatefulWidget {
  const OnboardingPageViewBody({super.key});

  @override
  State<OnboardingPageViewBody> createState() => _OnboardingPageViewBodyState();
}

class _OnboardingPageViewBodyState extends State<OnboardingPageViewBody> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> currentPage = ValueNotifier(0);

  void _onPageChanged(int page) {
    currentPage.value = page;
  }

  void _goToNextPage() {
    if (currentPage.value < 2) {
      _pageController.animateToPage(
        currentPage.value + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      GoRouter.of(context).go(Routes.loginView);
    }
  }

  void _goToBackPage() {
    if (currentPage.value > 0) {
      _pageController.animateToPage(
        currentPage.value - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = OnboardingConstClass.onboardingDataFun(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// الجزء المتغير فقط
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return OnboardingContent(data: data[index]);
              },
            ),
          ),

          const SizedBox(height: 32),

          /// ✅ الـ Indicator ثابت
          ValueListenableBuilder<int>(
            valueListenable: currentPage,
            builder: (context, value, _) {
              return OnboardingIndicatorSection(currentPage: value);
            },
          ),

          const SizedBox(height: 36),

          //جعل الأزرار ثابته لا تتغير ويعاد بناءة بتغير الصفحه
          ValueListenableBuilder<int>(
            valueListenable: currentPage,
            builder: (context, value, _) {
              return OnBoardingViewButtonSection(
                backOnPressed: _goToBackPage,
                nextButtonOnPressed: _goToNextPage,
                currentPage: value,
              );
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
