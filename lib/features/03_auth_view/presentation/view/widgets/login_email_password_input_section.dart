import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_button.dart';
import '../../../../../core/utilities/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/auth_bloc/auth_bloc.dart';

class LoginEmailPasswordInputSection extends StatefulWidget {
  const LoginEmailPasswordInputSection({super.key});

  @override
  State<LoginEmailPasswordInputSection> createState() =>
      _LoginEmailPasswordInputSectionState();
}

class _LoginEmailPasswordInputSectionState
    extends State<LoginEmailPasswordInputSection> {
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextFormField(
            text: S.of(context).authEmail,
            hintText: 'newuser@gmail.com',
            onSaved: (value) {
              email = value!.trim();
              debugPrint('email : $email');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).authEmailRequired;
              }
              return null;
            },
            textEditingController: textEditingControllerEmail,
          ),
          CustomTextFormField(
            text: S.of(context).authPassword,
            hintText: '**********',
            onSaved: (value) {
              password = value!.trim();
              debugPrint('password : $password');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).authPasswordRequired;
              }
              return null;
            },
            textEditingController: textEditingControllerPassword,
          ),
          const SizedBox(height: 8),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignInWithEmailSuccess) {
                ToastNotification.flatColoredToastNotificationService(
                  toastNotificationType: ToastificationType.success,
                  title: S.of(context).loginSuccessTitle,
                  description: S.of(context).loginSuccessDesc,
                  onAutoCompleteCompleted: (value) {
                    GoRouter.of(context).go(Routes.homeView);
                  },
                );
              } else if (state is SignInWithEmailFailure) {
                final errorMessage = state.errorMessage;
                ToastNotification.flatColoredToastNotificationService(
                  toastNotificationType: ToastificationType.error,
                  title: S.of(context).loginFailureTitle,
                  description: S.of(context).error(errorMessage),
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
                        _formKey.currentState!.save();
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
                    text: S.of(context).authSignIn,
                    isLoading: value,
                    textColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade600
                        : Colors.grey.shade200,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade200
                        : kPrimaryColor,
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
