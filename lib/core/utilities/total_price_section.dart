import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';

import '../../../../../generated/l10n.dart';

class TotalPriceSection extends StatelessWidget {
  const TotalPriceSection({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 2,
          children: [
            const Icon(Icons.attach_money_outlined, size: 16),
            CustomText(
              text: '${S.of(context).cartTotal} : ',
              fontSize: 14,
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        CustomText(
          text: '${priceShowed(total)} ${S.of(context).EP}',
          fontSize: 12,
          alignment: Alignment.centerLeft,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade200
              : kPrimaryColor,
        ),
      ],
    );
  }
}
