import 'package:flutter/material.dart';

import '../../../../../core/utilities/custom_text.dart';

class CustomIconTitle extends StatelessWidget {
  const CustomIconTitle({
    super.key,
    required this.iconData,
    required this.title,
    this.primaryColor = Colors.black87,
  });

  final IconData iconData;
  final String title;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: screenSize.width * .02,
      children: [
        Icon(
          iconData,
          size: 20,
          color: isDark ? Colors.grey.shade100 : Colors.black87,
        ),
        CustomText(
          text: title,
          fontSize: 16,
          alignment: Alignment.center,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.grey.shade100 : Colors.black87,
        ),
      ],
    );
  }
}
