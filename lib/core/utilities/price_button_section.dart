import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';

import '../../../../../core/utilities/custom_text.dart';

class PriceButtonSection extends StatelessWidget {
  const PriceButtonSection({
    super.key,
    required this.title,
    required this.value,
    required this.widget,
  });
  final String title, value;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * .12,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(16),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 8,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: title,
                    fontSize: 14,
                    alignment: Alignment.centerLeft,
                    color: kGreyColor,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: value,
                    fontSize: 18,
                    alignment: Alignment.centerLeft,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade200
                        : kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: widget),
        ],
      ),
    );
  }
}
