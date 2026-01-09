import 'package:flutter/material.dart';

class CustomCircleIndicator extends StatelessWidget {
  const CustomCircleIndicator({
    super.key,
    this.color,
    this.width = 3,
    this.size = 20,
  });

  final Color? color;
  final double width;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color:
              color ??
              (Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200),
          strokeWidth: width,
        ),
      ),
    );
  }
}
