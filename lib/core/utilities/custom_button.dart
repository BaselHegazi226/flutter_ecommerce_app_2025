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
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(paddingValue),
        elevation: 1,
        backgroundColor:
            backgroundColor ?? (isDark ? Colors.grey.shade400 : kScaffoldColor),
      ),

      onPressed: onPressed,
      child: isLoading
          ? const CustomCircleIndicator()
          : CustomText(
              text: text,
              color: textColor,
              fontSize: textSize,
              alignment: Alignment.center,
              fontWeight: fontWeight,
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
    this.isLoading = false,
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
  final IconData iconData;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: paddingValue),
        elevation: 1,
        backgroundColor:
            backgroundColor ?? (isDark ? Colors.grey.shade400 : kScaffoldColor),
      ),

      onPressed: onPressed,
      child: isLoading
          ? const CustomCircleIndicator()
          : Row(
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
                Icon(
                  iconData,
                  size: 20,
                  color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
                ),
              ],
            ),
    );
  }
}
