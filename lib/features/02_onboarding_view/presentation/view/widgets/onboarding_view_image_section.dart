import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingViewImageSection extends StatelessWidget {
  const OnBoardingViewImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: SvgPicture.asset(image, fit: BoxFit.contain),
    );
  }
}
