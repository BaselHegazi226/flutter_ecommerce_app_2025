import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

import 'icon_with_circle_style.dart';

customAppBar(BuildContext context, String title, VoidCallback onPressed) {
  return AppBar(
    title: CustomText(
      text: title,
      fontSize: 20,
      height: 1,
      maxLines: 1,
      fontWeight: FontWeight.w700,
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: IconWithCircleStyle(
        backgroundColor: Colors.grey.shade500.withAlpha(32),
        widget: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    ),
  );
}
