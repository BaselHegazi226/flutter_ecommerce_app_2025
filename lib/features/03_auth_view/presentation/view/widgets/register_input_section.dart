import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/helper/fields_contranits.dart';
import '../../../../../core/helper/routes.dart';
import '../../../../../core/utilities/custom_button.dart';
import '../../../../../core/utilities/custom_text_form_field.dart';
import '../../../../../core/utilities/toastnotification.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/auth_bloc/auth_bloc.dart';

class RegisterInputSection extends StatefulWidget {
  const RegisterInputSection({super.key});

  @override
  State<RegisterInputSection> createState() => _RegisterInputSectionState();
}

class _RegisterInputSectionState extends State<RegisterInputSection> {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  TextEditingController textEditingControllerName = TextEditingController();
  String email = '', password = '', name = '';
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
            text: S.of(context).authName,
            hintText: 'name',
            onSaved: (value) {
              name = value!.trim();
              debugPrint('name : $name');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).authNameRequired;
              } else if (!FieldsContranits.nameReg.hasMatch(value)) {
                return S.of(context).authEnterValidName;
              }
              return null;
            },
            textEditingController: textEditingControllerName,
          ),
          CustomTextFormField(
            text: S.of(context).authEmail,
            hintText: 'iamdavid@gmail.com',
            onSaved: (value) {
              email = value!.trim();
              debugPrint('email : $email');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).authEmailRequired;
              } else if (!FieldsContranits.emailReg.hasMatch(value)) {
                return S.of(context).auth_enterValidEmail;
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
              } else if (!FieldsContranits.passwordReg.hasMatch(value)) {
                return S.of(context).authEnterStrongPassword;
              }
              return null;
            },
            textEditingController: textEditingControllerPassword,
          ),
          const SizedBox(height: 8),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignUpWithEmailSuccess) {
                debugPrint('sign up success');
                ToastNotification.flatColoredToastNotificationService(
                  title: S.of(context).registerSuccessTitle,
                  description: S.of(context).registerSuccessDesc,
                  toastNotificationType: ToastificationType.success,
                  onAutoCompleteCompleted: (value) {
                    GoRouter.of(context).go(Routes.homeView);
                  },
                );
              } else if (state is SignUpWithEmailFailure) {
                final errorMessage = state.errorMessage;
                ToastNotification.flatColoredToastNotificationService(
                  toastNotificationType: ToastificationType.error,
                  title: S.of(context).registerFailureTitle,
                  description: S.of(context).error(errorMessage),
                  onAutoCompleteCompleted: (value) {},
                );
              }
            },
            builder: (context, state) {
              changeIsLoadingValue(state);
              return ValueListenableBuilder(
                valueListenable: isLoadingValueNotifier,
                builder: (context, value, child) {
                  return CustomButton(
                    text: S.of(context).authSignUp,
                    isLoading: value,
                    textSize: 18,
                    textColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade600
                        : Colors.grey.shade200,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade200
                        : kPrimaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context.read<AuthBloc>().add(
                          SignUpWithEmailEvent(
                            name: name,
                            email: email,
                            password: password,
                          ),
                        );
                      } else {
                        autoValidateMode = AutovalidateMode.always;
                      }
                    },
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
    isLoadingValueNotifier.value = state is SignUpWithEmailLoading;
  }
}
