import 'package:flutter/material.dart';

class CustomCircleIndicator extends StatelessWidget {
  const CustomCircleIndicator({
    super.key,
    this.color = Colors.white,
    this.width = 3,
    this.size = 20,
  });
  final Color color;
  final double width;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(color: color, strokeWidth: width),
      ),
    );
  }
}
