import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/l10n.dart';

class BestSellingHeader extends StatelessWidget {
  const BestSellingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: S.of(context).BestSelling,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        InkWell(
          onTap: () {
            GoRouter.of(
              context,
            ).push('${Routes.homeView}${Routes.showAllView}');
          },
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: CustomText(
            text: S.of(context).ShowAll,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
