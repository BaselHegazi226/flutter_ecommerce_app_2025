import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view/widgets/profile_view_body.dart';

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
          appBar: customTabsAppbar(context, S.of(context).navProfile),
          body: const ProfileViewBody(),
        ),
      ),
    );
  }
}
