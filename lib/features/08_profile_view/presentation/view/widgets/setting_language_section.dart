import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../../../../core/utilities/icon_with_circle_style.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/settings_cubit/settings_cubit.dart';
import 'setting_icon_title.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettingCubit = AppSettingCubit.get(context);
    final currentLanguage = AppSettingCubit.currentLanguage;

    String dropdownValue = currentLanguage == LanguageEnum.arabic
        ? 'العربية'
        : currentLanguage == LanguageEnum.english
        ? 'English'
        : 'English';

    return Column(
      spacing: 16,
      children: [
        CustomIconTitle(
          iconData: Icons.language_outlined,
          title: S.of(context).settingsLanguage,
        ),
        Container(
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

            icon: IconWithCircleStyle(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade50.withAlpha(32)
                  : Colors.grey.shade300.withAlpha(32),
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade100
                    : Colors.grey.shade400,
                size: 24,
              ),
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
        ),
      ],
    );
  }
}
