import 'package:flutter/material.dart';

import '../../core/helper/const.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    super.key,
    required this.onPressed,
    this.iconData = Icons.arrow_forward_outlined,
    this.iconColor = Colors.white,
    this.backgroundColor = kPrimaryColor,
    this.borderColor = Colors.transparent,
    this.enableGradient = false,
  });

  final VoidCallback onPressed;
  final IconData iconData;
  final Color iconColor, backgroundColor, borderColor;
  final bool enableGradient;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(64)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(color: borderColor),
          gradient: enableGradient
              ? isDark
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey.shade300,
                          Colors.white,
                          Colors.grey.shade200,
                        ],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff7fe0b8), // mint highlight
                          Color(0xff3d9970), // primary
                          Color(0xff2a6f56),
                        ], // deep shadow],
                        stops: [0.0, 0.55, 1.0],
                      )
              : null,
        ),
        child: Icon(iconData, size: 24, color: iconColor),
      ),
    );
  }
}
