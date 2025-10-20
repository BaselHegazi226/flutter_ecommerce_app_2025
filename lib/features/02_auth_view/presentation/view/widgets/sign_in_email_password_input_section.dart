import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view_model/auth_bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/utilities/custom_button.dart';
import '../../../../../core/utilities/custom_text_form_field.dart';

class SignInEmailPasswordInputSection extends StatefulWidget {
  const SignInEmailPasswordInputSection({super.key});

  @override
  State<SignInEmailPasswordInputSection> createState() =>
      _SignInEmailPasswordInputSectionState();
}

class _SignInEmailPasswordInputSectionState
    extends State<SignInEmailPasswordInputSection> {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  String email = '', password = '';
  ValueNotifier<bool> isLoadingValueNotifier = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    isLoadingValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
          CustomTextFormField(
            text: 'Email',
            hintText: 'iamdavid@gmail.com',
            onSaved: (value) {
              email = value!.trim();
              debugPrint('email : $email');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'email is required';
              }
              return null;
            },
            textEditingController: textEditingControllerEmail,
          ),
          CustomTextFormField(
            text: 'Password',
            hintText: '**********',
            onSaved: (value) {
              password = value!.trim();
              debugPrint('password : $password');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'password is required';
              }
              return null;
            },
            textEditingController: textEditingControllerPassword,
          ),
          const CustomText(
            text: 'Forget Password?',
            fontSize: 14,
            alignment: Alignment.topRight,
          ),
          const SizedBox(height: 8),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignInWithEmailSuccess) {
                ToastNotification.flatColoredToastNotificationService(
                  toastNotificationType: ToastificationType.success,
                  onAutoCompleteCompleted: (value) {
                    debugPrint('value = $value');
                    GoRouter.of(context).push(Routes.homeView);
                  },
                );
              } else if (state is SignInWithEmailFailure) {
                ToastNotification.flatColoredToastNotificationService(
                  toastNotificationType: ToastificationType.error,
                  title: "Sign in Failure",
                  description: state.errorMessage,
                  onAutoCompleteCompleted: (value) {
                    debugPrint('value = $value');
                  },
                );

                debugPrint(
                  'failure for sing in with email and password = ${state.errorMessage}',
                );
              }
            },
            builder: (context, state) {
              changeIsLoadingValue(state);
              return ValueListenableBuilder(
                valueListenable: isLoadingValueNotifier,
                builder: (context, value, child) {
                  return CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          SignInWithEmailEvent(
                            email: email,
                            password: password,
                          ),
                        );
                      } else {
                        autoValidateMode = AutovalidateMode.onUserInteraction;
                      }
                    },
                    text: 'Sign In',
                    isLoading: value,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void changeIsLoadingValue(AuthState state) {
    isLoadingValueNotifier.value = state is SignInWithEmailLoading;
  }
}
