import 'package:flutter/material.dart';

class IconWithCircleStyle extends StatelessWidget {
  const IconWithCircleStyle({
    super.key,

    this.backgroundColor = const Color(0xffFAFAFA),
    required this.icon,
    required this.onPressed,
    this.paddingValue = 4,
  });

  final Color? backgroundColor;
  final VoidCallback onPressed;
  final Icon icon;
  final double paddingValue;

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
      child: IconButton(
        padding: EdgeInsets.all(paddingValue),
        splashColor: Colors.transparent,
        onPressed: BorderRadius.only,
        icon: icon,
      ),
    );
  }
}
