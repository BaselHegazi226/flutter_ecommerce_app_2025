import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingViewImageSection extends StatelessWidget {
  const OnBoardingViewImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      mobileWidget: OnboardingViewImageSectionMobile(image: image),
      tabletWidget: OnboardingViewImageSectionTablet(image: image),
    );
  }
}

class OnboardingViewImageSectionMobile extends StatelessWidget {
  const OnboardingViewImageSectionMobile({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return SvgPicture.asset(
      image,
      height: screenHeight * .4,
      width: screenWidth * .35,
      fit: BoxFit.contain,
    );
  }
}

class OnboardingViewImageSectionTablet extends StatelessWidget {
  const OnboardingViewImageSectionTablet({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: SvgPicture.asset(image, fit: BoxFit.contain),
    );
  }
}
