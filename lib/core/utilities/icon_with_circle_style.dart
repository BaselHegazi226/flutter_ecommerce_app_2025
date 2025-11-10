import 'package:flutter/material.dart';

class IconWithCircleStyle extends StatelessWidget {
  const IconWithCircleStyle({
    super.key,
    required this.widget,
    this.backgroundColor = const Color(0xffFAFAFA),
  });
  final Widget widget;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: screenSize.width * .1,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade500.withAlpha(32)
                : const Color(0xffFAFAFA)),
        shape: BoxShape.circle,
      ),
      child: widget,
    );
  }
}
