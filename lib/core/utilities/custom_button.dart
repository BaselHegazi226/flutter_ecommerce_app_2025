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
    this.textSize = 20,
    this.isLoading = false,
  });
  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double textSize;
  final double paddingValue;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(paddingValue),
        elevation: 0,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: borderColor),
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? const CustomCircleIndicator()
          : CustomText(
              text: text,
              color: textColor,
              fontSize: textSize,
              alignment: Alignment.center,
            ),
    );
  }
}
