import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    this.imageWidthPar,
    required this.child,
    this.enableBorder = true,
  });

  final double? imageWidthPar;
  final Widget child;
  final bool enableBorder;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final imageWidth = imageWidthPar != null
        ? imageWidthPar! / 2
        : size.width * .4;
    return Container(
      width: imageWidth,
      decoration: BoxDecoration(
        border: enableBorder
            ? Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade200
                    : Colors.grey.shade800,
              )
            : null,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: imageWidth / 2,
        backgroundColor: Colors.transparent,
        child: ClipOval(child: child),
      ),
    );
  }
}
