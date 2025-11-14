import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../../../generated/l10n.dart';
import '../view_model/settings_cubit/settings_cubit.dart';
import '../view_model/settings_cubit/settings_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, S.of(context).Settings, () {
          GoRouter.of(context).pushReplacement(Routes.profileView);
        }),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AppSettingCubit, AppSettingStates>(
            builder: (context, state) {
              return const CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      spacing: 16,
                      children: [
                        NotificationSection(),
                        ModeSection(),
                        LanguageSection(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SettingViewItem extends StatelessWidget {
  const SettingViewItem({
    super.key,
    required this.title,
    this.subtitle = 'On / Off',
    required this.iconData,
    this.onChanged,
    this.isDarkMode,
  });

  final String title, subtitle;
  final IconData iconData;
  final void Function(dynamic)? onChanged;
  final bool? isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        CustomIconTitle(iconData: iconData, title: title),
        CustomSettingsContainer(
          child: CustomTitleSwitch(
            title: subtitle,
            onChanged: onChanged,
            isDarkMode: isDarkMode,
          ),
        ),
      ],
    );
  }
}

class CustomIconTitle extends StatelessWidget {
  const CustomIconTitle({
    super.key,
    required this.iconData,
    required this.title,
    this.textColor = Colors.black,
    this.iconColor = kGreyColor,
  });
  final IconData iconData;
  final String title;
  final Color textColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: screenSize.width * .02,
      children: [
        Icon(iconData, size: 24, color: iconColor),
        CustomText(
          text: title,
          fontSize: 16,
          alignment: Alignment.center,
          color: textColor,
        ),
      ],
    );
  }
}

class CustomSettingsContainer extends StatelessWidget {
  const CustomSettingsContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class CustomTitleSwitch extends StatelessWidget {
  const CustomTitleSwitch({
    super.key,
    required this.title,
    required this.onChanged,
    this.isDarkMode,
  });

  final String title;
  final void Function(dynamic)? onChanged;
  final bool? isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontSize: 18,
            alignment: Alignment.centerLeft,
            color: Colors.grey.shade900,
          ),
          CustomAdvancedSwitch(onChanged: onChanged, isDarkMode: isDarkMode),
        ],
      ),
    );
  }
}

class CustomAdvancedSwitch extends StatefulWidget {
  const CustomAdvancedSwitch({
    super.key,
    required this.onChanged,
    this.isDarkMode,
  });

  final void Function(dynamic)? onChanged;
  final bool? isDarkMode;

  @override
  State<CustomAdvancedSwitch> createState() => _CustomAdvancedSwitchState();
}

class _CustomAdvancedSwitchState extends State<CustomAdvancedSwitch> {
  late final ValueNotifier<bool> _controller;

  @override
  void initState() {
    super.initState();
    _controller = ValueNotifier<bool>(widget.isDarkMode ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      onChanged: widget.onChanged,
      controller: _controller,
      activeColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade900
          : kPrimaryColor,
      inactiveColor: Colors.grey.shade400,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      width: 52.0,
      height: 24.0,
      enabled: true,
      disabledOpacity: 0.5,
      thumb: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingViewItem(
      title: S.of(context).Notifications,
      iconData: Icons.notifications_active,
      subtitle: S.of(context).OnOff,
    );
  }
}

class ModeSection extends StatelessWidget {
  const ModeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettingCubit = AppSettingCubit.get(context);
    bool isDark = appSettingCubit.isDarkModeEnabled();
    debugPrint('isDark  = $isDark');
    return BlocConsumer<AppSettingCubit, AppSettingStates>(
      listener: (context, state) {
        if (state is SelectedThemeSuccess) {
          isDark = appSettingCubit.isDarkModeEnabled();
        }
      },
      builder: (context, state) {
        return Column(
          spacing: 16,
          children: [
            CustomIconTitle(
              iconData: isDark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              title: S.of(context).Mode,
            ),
            CustomSettingsContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: isDark ? S.of(context).Dark : S.of(context).Light,
                      fontSize: 16,
                      alignment: Alignment.center,
                      color: Colors.grey.shade900,
                    ),
                    IconWithCircleStyle(
                      backgroundColor: isDark
                          ? Colors.grey.shade200
                          : Colors.grey.shade400,
                      widget: IconButton(
                        padding: const EdgeInsets.all(4),
                        onPressed: () {
                          appSettingCubit.selectedTheme(
                            theme: isDark ? ThemeMode.light : ThemeMode.dark,
                          );
                        },
                        icon: Icon(
                          isDark
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

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
          title: S.of(context).Language,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[850]
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            underline: const SizedBox(),
            value: dropdownValue,
            isExpanded: true,
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
                    const SizedBox(width: 8),
                    Text(value),
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
