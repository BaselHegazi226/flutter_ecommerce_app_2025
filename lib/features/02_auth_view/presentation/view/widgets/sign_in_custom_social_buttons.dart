import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:iconify_flutter/icons/fa6_brands.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/utilities/custom_social_button.dart';
import '../../view_model/auth_bloc/auth_bloc.dart';

class SignInCustomSocialButtons extends StatefulWidget {
  const SignInCustomSocialButtons({super.key});

  @override
  State<SignInCustomSocialButtons> createState() =>
      _SignInCustomSocialButtonsState();
}

class _SignInCustomSocialButtonsState extends State<SignInCustomSocialButtons> {
  ValueNotifier<bool> valueNotifierLoadingGoogle = ValueNotifier(false);
  ValueNotifier<bool> valueNotifierLoadingFacebook = ValueNotifier(false);
  @override
  void dispose() {
    valueNotifierLoadingGoogle.dispose();
    valueNotifierLoadingFacebook.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing:
          valueNotifierLoadingGoogle.value ||
          valueNotifierLoadingFacebook.value,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          listenerBody(state);
        },
        builder: (context, state) {
          //تم وضعها هنا لأن ال builder هو المسؤول عن التغيير في ال ui
          changeLoadingStateValue(state);
          return Column(
            spacing: 20,
            children: [
              CustomSocialButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignInWithGoogleEvent());
                },
                valueNotifierLoading: valueNotifierLoadingGoogle,
                text: 'Sign In with Google',
                iconifyData: Logos.google_icon,
              ),
              CustomSocialButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignInWithFacebookEvent());
                },
                valueNotifierLoading: valueNotifierLoadingFacebook,
                text: 'Sign In with Facebook',
                iconifyColor: const Color(0xff475993),
                iconifyData: Fa6Brands.square_facebook,
              ),
            ],
          );
        },
      ),
    );
  }

  void listenerBody(AuthState state) {
    if (state is SignInWithGoogleSuccess) {
      ToastNotification.flatColoredToastNotificationService(
        title: 'Success Sign In With Google',
        description: 'go to your journey',
        onAutoCompleteCompleted: (value) {},
      );
    } else if (state is SignInWithFacebookSuccess) {
      ToastNotification.flatColoredToastNotificationService(
        title: 'Success Sign In With Facebook',
        description: 'go to your journey',
        onAutoCompleteCompleted: (value) {},
      );
    } else if (state is SignInWithGoogleFailure) {
      ToastNotification.flatColoredToastNotificationService(
        toastNotificationType: ToastificationType.error,
        title: 'Failure Sign In With Google',
        description: 'try again!',
        onAutoCompleteCompleted: (value) {},
      );
    } else if (state is SignInWithFacebookFailure) {
      ToastNotification.flatColoredToastNotificationService(
        toastNotificationType: ToastificationType.error,
        title: 'Failure Sign In With Facebook',
        description: state.errorMessage,
        onAutoCompleteCompleted: (value) {},
      );
    }
  }

  void changeLoadingStateValue(AuthState state) {
    valueNotifierLoadingFacebook.value = state is SignInWithFacebookLoading;
    valueNotifierLoadingGoogle.value = state is SignInWithGoogleLoading;
  }
}
