import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';

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
          text: S.of(context).homeCategories,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
