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
import '../../../../../core/utilities/password_widget/password_with_overlay.dart';
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
            iconData: Icons.person_outline_outlined,
            text: S.of(context).authName,
            hintText: 'name',
            onSaved: (value) => name = value!.trim(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).authNameRequired;
              } else if (!FieldsConstraints.nameReg.hasMatch(value)) {
                return S.of(context).authEnterValidName;
              }
              return null;
            },
            textEditingController: textEditingControllerName,
          ),

          CustomTextFormField(
            iconData: Icons.email_outlined,
            text: S.of(context).authEmail,
            hintText: 'iamdavid@gmail.com',
            onSaved: (value) => email = value!.trim(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).authEmailRequired;
              } else if (!FieldsConstraints.emailReg.hasMatch(value)) {
                return S.of(context).auth_enterValidEmail;
              }
              return null;
            },
            textEditingController: textEditingControllerEmail,
          ),

          /// 🔥 Password With Overlay
          PasswordWithOverlayBody(
            controller: textEditingControllerPassword,
            labelText: S.of(context).authPassword,
            hintText: '12B!b2331',
            onSaved: (value) => password = value!.trim(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).authPasswordRequired;
              } else if (!FieldsConstraints.passwordReg.hasMatch(value)) {
                return S.of(context).authEnterStrongPassword;
              }
              return null;
            },
          ),

          const SizedBox(height: 8),

          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignUpWithEmailSuccess) {
                ToastNotification.flatColoredToastNotificationService(
                  title: S.of(context).registerSuccessTitle,
                  description: S.of(context).registerSuccessDesc,
                  toastNotificationType: ToastificationType.success,
                  onAutoCompleteCompleted: (value) {
                    GoRouter.of(context).go(Routes.homeView);
                  },
                );
              } else if (state is SignUpWithEmailFailure) {
                ToastNotification.flatColoredToastNotificationService(
                  toastNotificationType: ToastificationType.error,
                  title: S.of(context).registerFailureTitle,
                  description: S.of(context).error(state.errorMessage),
                  onAutoCompleteCompleted: (value) {},
                );
              }
            },
            builder: (context, state) {
              isLoadingValueNotifier.value = state is SignUpWithEmailLoading;

              return ValueListenableBuilder(
                valueListenable: isLoadingValueNotifier,
                builder: (context, isLoading, _) {
                  return CustomButton(
                    text: S.of(context).authSignUp,
                    isLoading: isLoading,
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
}
