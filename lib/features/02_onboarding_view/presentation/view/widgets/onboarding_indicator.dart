import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * .01),
      width: screenWidth * .12,
      height: isActive ? screenHeight * .005 : screenHeight * .0025,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : kGreyColor,
      ),
    );
  }
}
