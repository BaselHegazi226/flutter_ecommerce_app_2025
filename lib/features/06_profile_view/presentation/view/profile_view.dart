import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/profile_view_body.dart';

import '../../../../generated/l10n.dart';
import '../view_model/user_info_cubit/user_info_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build account view');
    return BlocProvider(
      create: (context) => UserInfoCubit()..getUserInfo(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            title: CustomText(text: S.of(context).profile, fontSize: 20),
            centerTitle: true,
          ),
          body: const ProfileViewBody(),
        ),
      ),
    );
  }
}
