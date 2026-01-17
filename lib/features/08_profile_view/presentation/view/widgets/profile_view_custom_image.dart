import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    this.imageSize = 100,
    required this.imageProvider,
    this.enableBorder = true,
    this.borderColor = Colors.grey,
    this.borderWidth = 2.0,
  });

  final double imageSize;
  final Widget imageProvider;
  final bool enableBorder;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: enableBorder
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: ClipOval(
        child: SizedBox(
          width: imageSize,
          height: imageSize,
          child: FittedBox(
            fit: BoxFit.cover, // يحافظ على الصورة أو أي Widget
            clipBehavior: Clip.hardEdge,
            child: imageProvider,
          ),
        ),
      ),
    );
  }
}
