import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import 'custom_text.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.iconifyData,
    this.iconifyColor,
    required this.valueNotifierLoading,
  });

  final void Function()? onPressed;
  final String text;
  final String iconifyData;
  final Color? iconifyColor;
  final ValueNotifier<bool> valueNotifierLoading;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifierLoading,
      builder: (context, value, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: Color(0xffDDDDDD)),
            ),
          ),
          onPressed: onPressed,
          child: value
              ? CustomCircleIndicator(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade200
                      : Colors.grey.shade800,
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    /// الأيقونة دايمًا على الشمال
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Iconify(
                        iconifyData,
                        color: iconifyColor,
                        size: 24,
                      ),
                    ),

                    /// النص دايمًا في النص
                    CustomText(
                      text: text,
                      fontSize: 18,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
