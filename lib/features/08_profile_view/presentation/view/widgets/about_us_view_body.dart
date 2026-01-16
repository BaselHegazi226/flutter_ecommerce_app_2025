import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import 'about_us_item.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        AboutUsItem(
          title: S.of(context).aboutMeSummary,
          value: CustomText(text: S.of(context).aboutMeDesc, fontSize: 14),
        ),
        AboutUsItem(
          title: S.of(context).aboutMeTechnicalSkills,
          value: buildTechnicalSkillsList(context),
        ),
        AboutUsItem(
          title: S.of(context).aboutMeAppsDevelopment,
          value: buildAppsDevelopmentList(context),
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
      S.of(context).aboutMeSkillFlutter,
      S.of(context).aboutMeSkillStateManagement,
      S.of(context).aboutMeSkillFirebase,
      S.of(context).aboutMeSkillRestApi,
      S.of(context).aboutMeSkillArchitecture,
      S.of(context).aboutMeSkillResponsiveUi,
      S.of(context).aboutMeSkillLocalization,
      S.of(context).aboutMeSkillGit,
      S.of(context).aboutMeSkillCustomUi,
    ];
    return Column(
      spacing: 4,
      children: List.generate(skills.length, (index) {
        return buildPointValueItem(skills[index]);
      }),
    );
  }

  buildAppsDevelopmentList(BuildContext context) {
    final List<String> apps = [
      S.of(context).aboutMeAppEcommerce,
      S.of(context).aboutMeAppManagement,
      S.of(context).aboutMeAppChat,
      S.of(context).aboutMeAppContent,
      S.of(context).aboutMeAppFirebase,
      S.of(context).aboutMeAppMultilang,
      S.of(context).aboutMeAppApi,
      S.of(context).aboutMeAppAdmin,
    ];
    return Column(
      spacing: 4,
      children: List.generate(apps.length, (index) {
        return buildPointValueItem(apps[index]);
      }),
    );
  }
}
