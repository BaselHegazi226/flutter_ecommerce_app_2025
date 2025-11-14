import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

import '../../../../../generated/l10n.dart';

class BestSellingHeader extends StatelessWidget {
  const BestSellingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: S.of(context).BestSelling, fontSize: 18),
        CustomText(text: S.of(context).SellAll, fontSize: 18),
      ],
    );
  }
}
