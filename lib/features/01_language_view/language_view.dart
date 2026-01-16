import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../core/helper/const.dart';
import '../../core/utilities/custom_circle_button.dart';
import '../../core/utilities/custom_text.dart';
import '../08_profile_view/presentation/view_model/settings_cubit/settings_cubit.dart';
import '../08_profile_view/presentation/view_model/settings_cubit/settings_state.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettingCubit = AppSettingCubit.get(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AppSettingCubit, AppSettingStates>(
            builder: (context, state) {
              return Column(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: S.of(context).language_selected_text,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const LanguageSectionInLang(),
                ],
              );
            },
          ),
        ),
        floatingActionButton: CustomCircleButton(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade500.withAlpha(124)
              : kPrimaryColor,
          iconColor: Colors.grey.shade50,
          onPressed: () {
            GoRouter.of(context).push(Routes.onBoardingView);
          },
        ),
      ),
    );
  }
}

class LanguageSectionInLang extends StatelessWidget {
  const LanguageSectionInLang({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettingCubit = AppSettingCubit.get(context);
    final currentLanguage = AppSettingCubit.currentLanguage;

    String dropdownValue = currentLanguage == LanguageEnum.arabic
        ? 'العربية'
        : currentLanguage == LanguageEnum.english
        ? 'English'
        : 'English';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade200
              : Colors.grey.shade500,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<String>(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        dropdownColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade100
            : Colors.grey.shade800,
        underline: const SizedBox(),
        value: dropdownValue,
        isExpanded: true,
        // 👇 هنا بنظبط شكل العنصر المختار قبل الفتح
        selectedItemBuilder: (BuildContext context) {
          return ['العربية', 'English'].map((String value) {
            return Row(
              children: [
                value == 'العربية'
                    ? const Iconify(Twemoji.flag_for_flag_egypt, size: 20)
                    : const Iconify(
                        Twemoji.flag_for_flag_united_states,
                        size: 20,
                      ),
                const SizedBox(width: 12),
                Text(value),
              ],
            );
          }).toList();
        },

        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Theme.of(context).iconTheme.color,
        ),
        onChanged: (String? value) {
          if (value != null) {
            final language = value == 'العربية'
                ? LanguageEnum.arabic
                : LanguageEnum.english;
            appSettingCubit.selectedLanguage(language: language);
          }
        },

        // عناصر القائمه الفعليه
        items: ['العربية', 'English'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                value == 'العربية'
                    ? const Iconify(Twemoji.flag_for_flag_egypt, size: 20)
                    : const Iconify(
                        Twemoji.flag_for_flag_united_states,
                        size: 20,
                      ),
                const SizedBox(width: 12),
                Text(
                  value,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade800
                        : Colors.grey.shade100,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
