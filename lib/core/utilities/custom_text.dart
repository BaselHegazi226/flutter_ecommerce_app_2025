import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.alignment,
    this.height = 1.5,
    this.maxLines = 10,
  });
  final String text;
  final double fontSize;
  final int maxLines;
  final Color color;
  final FontWeight fontWeight;
  final Alignment? alignment;
  final double height;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: fontSize),
        fontWeight: fontWeight,
        height: height,
        color: color == Colors.black
            ? Theme.of(context).textTheme.bodyMedium?.color
            : color,
      ),
      softWrap: true,
    );

    // لو alignment مش متحدد، رجع النص عادي من غير Align
    return alignment == null
        ? textWidget
        : Align(alignment: alignment!, child: textWidget);
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
