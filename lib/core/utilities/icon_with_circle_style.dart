import 'package:flutter/material.dart';

class IconWithCircleStyle extends StatelessWidget {
  const IconWithCircleStyle({
    super.key,
    required this.widget,
    this.backgroundColor = const Color(0xffFAFAFA),
  });
  final Widget widget;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: widget,
    );
  }
}
