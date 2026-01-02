import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/setting_custom_container.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/setting_icon_title.dart';

import '../../../../../generated/l10n.dart';
import '../../view_model/settings_cubit/settings_cubit.dart';
import '../../view_model/settings_cubit/settings_state.dart';

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
              title: S.of(context).settingsMode,
            ),
            CustomSettingsContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: isDark
                          ? S.of(context).settingsDark
                          : S.of(context).settingsLight,
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
