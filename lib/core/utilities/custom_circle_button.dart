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
  });

  final VoidCallback onPressed;
  final IconData iconData;
  final Color iconColor, backgroundColor, borderColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
      ),
      onPressed: onPressed,
      child: Icon(iconData, size: 24, color: iconColor),
    );
  }
}
