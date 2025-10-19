import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    required this.alignment,
    this.height = 1.5,
    this.maxLines = 10,
  });
  final String text;
  final double fontSize;
  final int maxLines;
  final Color color;
  final FontWeight fontWeight;
  final Alignment alignment;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: getResponsiveFontSize(context, fontSize: fontSize),
          fontWeight: fontWeight,
          height: height,
        ),
        softWrap: true,
      ),
    );
  }
}

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;
  double lowerFontSize = fontSize * .8;
  double upperFontSize = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerFontSize, upperFontSize);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}
