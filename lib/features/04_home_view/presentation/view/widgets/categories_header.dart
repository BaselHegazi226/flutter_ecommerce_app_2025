import 'package:flutter/material.dart';

import '../../../../../core/utilities/custom_text.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomText(
      text: 'Categories',
      fontSize: 18,
      alignment: Alignment.topLeft,
    );
  }
}
