import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import 'about_us_item.dart';

class AboutAppViewBody extends StatelessWidget {
  const AboutAppViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        AboutUsItem(
          title: S.of(context).aboutAppSummary,
          value: CustomText(text: S.of(context).aboutMeDesc, fontSize: 14),
        ),
        AboutUsItem(
          title: S.of(context).aboutAppFeaturesTitle,
          value: buildTechnicalSkillsList(context),
        ),
        AboutUsItem(
          title: S.of(context).aboutAppTechnicalTitle,
          value: buildAppsFeaturesList(context),
        ),
      ],
    );
  }

  buildPointValueItem(String title) {
    return Row(
      spacing: 8,
      children: [
        const Icon(Icons.circle, size: 8),
        Flexible(child: CustomText(text: title, fontSize: 14)),
      ],
    );
  }

  buildTechnicalSkillsList(BuildContext context) {
    final List<String> skills = [
      S.of(context).aboutAppTechApi,
      S.of(context).aboutAppTechArchitecture,
      S.of(context).aboutAppTechFlutter,
      S.of(context).aboutAppTechLocalDb,
      S.of(context).aboutAppTechResponsive,
      S.of(context).aboutAppTechStateManagement,
    ];
    return Column(
      spacing: 4,
      children: List.generate(skills.length, (index) {
        return buildPointValueItem(skills[index]);
      }),
    );
  }

  buildAppsFeaturesList(BuildContext context) {
    final List<String> apps = [
      S.of(context).aboutAppFeatureProducts,
      S.of(context).aboutAppFeatureCart,
      S.of(context).aboutAppFeatureDelivery,
      S.of(context).aboutAppFeatureCheckout,
      S.of(context).aboutAppFeatureLocalStorage,
      S.of(context).aboutAppFeatureMultiLang,
      S.of(context).aboutAppFeatureOrders,
      S.of(context).aboutAppFeatureUi,
    ];
    return Column(
      spacing: 4,
      children: List.generate(apps.length, (index) {
        return buildPointValueItem(apps[index]);
      }),
    );
  }
}
