import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view/widgets/setting_language_section.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view/widgets/setting_mode_section.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';
import '../view_model/settings_cubit/settings_cubit.dart';
import '../view_model/settings_cubit/settings_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, S.of(context).settings_title, () {
          GoRouter.of(context).pop();
        }),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AppSettingCubit, AppSettingStates>(
            builder: (context, state) {
              return const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  spacing: 16,
                  children: [ModeSection(), LanguageSection()],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
