import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_snack_bar.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/repo/auth_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view_model/is_new_user_cubit/is_new_user_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view_model/is_new_user_cubit/is_new_user_state.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/assets.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            IsNewUserCubit(authRepo: AuthRepoImpl())..isNewUser(),
        child: BlocListener<IsNewUserCubit, IsNewUserState>(
          listener: (context, state) {
            if (state is IsNewUserSuccess) {
              debugPrint('i am in login');
              GoRouter.of(context).go(Routes.loginView);
            } else if (state is IsOldUser) {
              debugPrint('i am in home');
              GoRouter.of(context).go(Routes.homeView);
            } else if (state is IsNewUserFailure) {
              showSafeSnackBar(context, state.errorMessage, kPrimaryWrongColor);
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.splashEcommerce, height: 200),
                const SizedBox(height: 20),
                BlocBuilder<IsNewUserCubit, IsNewUserState>(
                  builder: (context, state) {
                    if (state is IsNewUserLoading) {
                      debugPrint('i am in loading state now');
                      return const CustomCircleIndicator(color: kPrimaryColor);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
