import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/helper/fields_contranits.dart';
import '../../../../../core/helper/routes.dart';
import '../../../../../core/utilities/custom_button.dart';
import '../../../../../core/utilities/custom_text_form_field.dart';
import '../../../../../core/utilities/toastnotification.dart';
import '../../view_model/auth_bloc/auth_bloc.dart';

class SignUpInputSection extends StatefulWidget {
  const SignUpInputSection({super.key});

  @override
  State<SignUpInputSection> createState() => _SignUpInputSectionState();
}

class _SignUpInputSectionState extends State<SignUpInputSection> {
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
            text: 'Name',
            hintText: 'name',
            onSaved: (value) {
              name = value!.trim();
              debugPrint('name : $name');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'name is required';
              } else if (!FieldsContranits.nameReg.hasMatch(value)) {
                return 'enter valid name';
              }
              return null;
            },
            textEditingController: textEditingControllerName,
          ),
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
              } else if (!FieldsContranits.emailReg.hasMatch(value)) {
                return 'enter valid email (email@gmail.com)';
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
              } else if (!FieldsContranits.passwordReg.hasMatch(value)) {
                return 'enter strong password';
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
                  toastNotificationType: ToastificationType.success,
                  onAutoCompleteCompleted: (value) {
                    GoRouter.of(context).go(Routes.homeView);
                  },
                );
              } else if (state is SignUpWithEmailFailure) {
                debugPrint('error = ${state.errorMessage}');
                ToastNotification.flatColoredToastNotificationService(
                  toastNotificationType: ToastificationType.error,
                  title: state.errorMessage,
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
                    text: 'Sign Up',
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
    isLoadingValueNotifier.value = state is SignUpWithEmailLoading;
  }
}
