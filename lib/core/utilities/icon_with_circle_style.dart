import 'package:flutter/material.dart';

class IconWithCircleStyle extends StatelessWidget {
  const IconWithCircleStyle({
    super.key,
    this.backgroundColor = const Color(0xffFAFAFA),
    required this.icon,
    required this.onPressed,
    this.paddingValue = 4,
    this.size = 40, // حجم الدائرة
  });

  final Color? backgroundColor;
  final VoidCallback onPressed;
  final Icon icon;
  final double paddingValue;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(), // 👈 أهم سطر
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                backgroundColor ??
                (Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade500.withAlpha(32)
                    : const Color(0xffFAFAFA)),
          ),
          child: Padding(padding: EdgeInsets.all(paddingValue), child: icon),
        ),
      ),
    );
  }
}
