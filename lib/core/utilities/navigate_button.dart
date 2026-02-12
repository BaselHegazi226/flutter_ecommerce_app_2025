import 'package:flutter/material.dart';

import '../helper/const.dart';
import 'custom_loading_indicator.dart';
import 'custom_text.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    super.key,
    this.isBack = false,
    required this.onPressed,
    required this.text,
    this.borderColor = Colors.transparent,
    this.backgroundColor = kPrimaryColor,
    this.textColor = Colors.white,
    this.paddingValue = 8,
    this.textSize = 14,
    this.isLoading = false,
    this.fontWeight = FontWeight.w700,
    this.iconSize = 14,
  });

  final bool isBack;

  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final double textSize;
  final double paddingValue;
  final double iconSize;
  final bool isLoading;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (isBack) {
      return _buildElevatedButtonBack(context, isDark);
    }
    return _buildElevatedButtonNext(isDark);
  }

  Widget _buildElevatedButtonNext(bool isDark) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isDark ? Colors.grey.shade400 : kScaffoldColor),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor ?? Colors.transparent),
          gradient: isDark
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade300,
                    Colors.white,
                    Colors.grey.shade200,
                  ],
                )
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff7fe0b8), // mint highlight
                    Color(0xff3d9970), // primary
                    Color(0xff2a6f56),
                  ], // deep shadow],
                  stops: [0.0, 0.55, 1.0],
                ),
        ),
        child: isLoading
            ? CustomCircleIndicator(color: textColor, size: 24)
            : Row(
                key: const ValueKey('content'),
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: text,
                    color: textColor,
                    fontSize: textSize,
                    alignment: Alignment.center,
                    fontWeight: fontWeight,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: iconSize,
                    color: textColor,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildElevatedButtonBack(BuildContext context, bool isDark) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),

        child: isLoading
            ? CustomCircleIndicator(color: textColor, size: 24)
            : Row(
                key: const ValueKey('content'),
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: iconSize,
                    color: textColor,
                  ),
                  CustomText(
                    text: text,
                    color: textColor,
                    fontSize: textSize,
                    alignment: Alignment.center,
                    fontWeight: fontWeight,
                  ),
                ],
              ),
      ),
    );
  }
}
