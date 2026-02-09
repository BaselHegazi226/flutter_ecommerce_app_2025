import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.borderColor = Colors.transparent,
    this.backgroundColor = kPrimaryColor,
    this.textColor = Colors.white,
    this.paddingValue = 12,
    this.textSize = 14,
    this.isLoading = false,
    this.enableGradient = true,
    this.fontWeight = FontWeight.w700,
  });

  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final double textSize;
  final double paddingValue;
  final bool isLoading;
  final bool enableGradient;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        padding: EdgeInsets.all(paddingValue),
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isDark ? Colors.grey.shade400 : kScaffoldColor),
          borderRadius: BorderRadius.circular(12),
          gradient: enableGradient
              ? isDark
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
                      )
              : null,
        ),
        child: isLoading
            ? CustomCircleIndicator(color: textColor, size: 24)
            : CustomText(
                key: const ValueKey('text'),
                text: text,
                color: textColor,
                fontSize: textSize,
                alignment: Alignment.center,
                fontWeight: fontWeight,
              ),
      ),
    );
  }
}

class CustomTextIconButton extends StatelessWidget {
  const CustomTextIconButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.iconData,
    this.borderColor = Colors.transparent,
    this.backgroundColor = kPrimaryColor,
    this.textColor = Colors.white,
    this.paddingValue = 8,
    this.textSize = 14,
    this.enableGradient = true,
    this.isLoading = false,
    this.fontWeight = FontWeight.w700,
    this.iconSize = 20,
  });

  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final double textSize;

  final double paddingValue;
  final double iconSize;
  final bool enableGradient;
  final bool isLoading;
  final IconData iconData;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        padding: EdgeInsets.all(paddingValue),
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isDark ? Colors.grey.shade400 : kScaffoldColor),
          borderRadius: BorderRadius.circular(12),
          gradient: enableGradient
              ? isDark
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
                      )
              : null,
        ),
        child: isLoading
            ? CustomCircleIndicator(color: textColor, size: 24)
            : Row(
                key: const ValueKey('content'),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: text,
                    color: textColor,
                    fontSize: textSize,
                    alignment: Alignment.center,
                    fontWeight: fontWeight,
                  ),
                  const SizedBox(width: 8),
                  Icon(iconData, size: iconSize, color: textColor),
                ],
              ),
      ),
    );
  }
}
