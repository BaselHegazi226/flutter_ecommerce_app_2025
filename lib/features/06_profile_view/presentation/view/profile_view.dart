import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/profile_view_body.dart';

import '../view_model/user_info_cubit/user_info_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build account view');
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => UserInfoCubit()..getUserInfo(),
          child: const ProfileViewBody(),
        ),
      ),
    );
  }
}
