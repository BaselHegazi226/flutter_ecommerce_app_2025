import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/helper/routes.dart';
import '../../../../../core/utilities/custom_social_button.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/auth_bloc/auth_bloc.dart';

class SignInCustomSocialButtons extends StatefulWidget {
  const SignInCustomSocialButtons({super.key});

  @override
  State<SignInCustomSocialButtons> createState() =>
      _SignInCustomSocialButtonsState();
}

class _SignInCustomSocialButtonsState extends State<SignInCustomSocialButtons> {
  ValueNotifier<bool> valueNotifierLoadingGoogle = ValueNotifier(false);

  @override
  void dispose() {
    valueNotifierLoadingGoogle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: valueNotifierLoadingGoogle.value,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          listenerBody(state);
        },
        builder: (context, state) {
          //تم وضعها هنا لأن ال builder هو المسؤول عن التغيير في ال ui
          changeLoadingStateValue(state);
          return CustomSocialButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignInWithGoogleEvent());
            },
            valueNotifierLoading: valueNotifierLoadingGoogle,
            text: S.of(context).authSignInWithGoogle,
            iconifyData: Logos.google_icon,
          );
        },
      ),
    );
  }

  void listenerBody(AuthState state) {
    if (state is SignInWithGoogleSuccess) {
      ToastNotification.flatColoredToastNotificationService(
        title: S.of(context).success_login_title,
        description: S.of(context).success_login_desc,
        onAutoCompleteCompleted: (value) {
          GoRouter.of(context).go(Routes.homeView);
        },
      );
    } else if (state is SignInWithGoogleFailure) {
      ToastNotification.flatColoredToastNotificationService(
        toastNotificationType: ToastificationType.error,
        title: S.of(context).failure_login_title,
        description: state.errorMessage,
        onAutoCompleteCompleted: (value) {},
      );
    }
  }

  void changeLoadingStateValue(AuthState state) {
    valueNotifierLoadingGoogle.value = state is SignInWithGoogleLoading;
  }
}
