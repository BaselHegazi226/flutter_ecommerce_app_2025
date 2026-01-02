import 'package:flutter/material.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_text.dart';

class CustomIconTitle extends StatelessWidget {
  const CustomIconTitle({
    super.key,
    required this.iconData,
    required this.title,
    this.textColor = Colors.black,
    this.iconColor = kGreyColor,
  });

  final IconData iconData;
  final String title;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: screenSize.width * .02,
      children: [
        Icon(iconData, size: 24, color: iconColor),
        CustomText(
          text: title,
          fontSize: 16,
          alignment: Alignment.center,
          color: textColor,
        ),
      ],
    );
  }
}
