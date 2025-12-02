import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    this.imageWidth,
    required this.child,
    this.enableBorder = true,
  });
  final double? imageWidth;
  final Widget child;
  final bool enableBorder;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: imageWidth ?? size.width * .5,
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
        radius: imageWidth != null ? imageWidth! / 2 : size.width * .5 / 2,
        backgroundColor: Colors.transparent,
        child: ClipOval(child: child),
      ),
    );
  }
}
