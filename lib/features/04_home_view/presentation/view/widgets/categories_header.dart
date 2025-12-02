import 'package:flutter/material.dart';

import '../../../../../core/utilities/custom_text.dart';
import '../../../../../generated/l10n.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomText(
          text: S.of(context).Categories,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
