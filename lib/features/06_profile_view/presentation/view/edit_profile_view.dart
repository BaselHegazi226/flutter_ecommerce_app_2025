import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/edit_profile_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.userInfoCubit});

  final UserInfoCubit userInfoCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditProfileCubit(userInfoCubit: userInfoCubit)..getCurrentUserData(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: customAppBar(context, S.of(context).profileEdit, () {
          GoRouter.of(context).pop();
        }),
        body: const EditProfileViewBody(),
      ),
    );
  }
}
