import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_snack_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_button.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/edit_profile_cubit/edit_profile_cubit.dart';
import '../../view_model/edit_profile_cubit/edit_profile_state.dart';

class InputSection extends StatefulWidget {
  const InputSection({super.key});

  @override
  State<InputSection> createState() => _InputSectionState();
}

class _InputSectionState extends State<InputSection> {
  String _name = '';
  final TextEditingController _textEditingControllerName =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _giveParameterValuesFun();
  }

  @override
  void dispose() {
    _textEditingControllerName.dispose();
    super.dispose();
  }

  void _giveParameterValuesFun() {
    final cubit = context.read<EditProfileCubit>();
    _textEditingControllerName.text = cubit.getUserModel!.name;
    _name = cubit.getUserModel!.name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileUpdatingSuccess) {
          ToastNotification.flatColoredToastNotificationService(
            onAutoCompleteCompleted: (value) {
              GoRouter.of(context).pop();
            },
            title: S.of(context).success_updateProfile_title,
            description: S.of(context).success_updateProfile_desc,
            toastNotificationType: ToastificationType.success,
          );
        } else if (state is EditProfileUpdatingFailure) {
          ToastNotification.flatColoredToastNotificationService(
            onAutoCompleteCompleted: (value) {
              GoRouter.of(context).pop();
            },
            title: S.of(context).failure_updateProfile_title,
            description: S.of(context).failure_updateProfile_desc,
            toastNotificationType: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserNameField(context, cubit),
              const SizedBox(height: 24),
              _buildUserEmailField(context, cubit),
              const SizedBox(height: 40),
              CustomButton(
                isLoading: state is EditProfileLoadingData,
                fontWeight: FontWeight.w700,
                textColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade600
                    : Colors.grey.shade200,
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade200
                    : kPrimaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<EditProfileCubit>().updateUserName(
                      newName: _name,
                    );
                    context.read<EditProfileCubit>().saveChanges();
                  } else {
                    showSafeSnackBar(context, 'Not changed Data', Colors.grey);
                  }
                },
                text: S.of(context).profileUpdateTitleButton,
              ),
            ],
          ),
        );
      },
    );
  }

  Column _buildUserEmailField(BuildContext context, EditProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: S.of(context).profileUserEmail, fontSize: 16),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: kGreyColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  spacing: 16,
                  children: [
                    const Icon(Icons.email_outlined),
                    Flexible(
                      child: CustomText(
                        text: cubit.getUserModel!.email,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit_off_outlined),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildUserNameField(BuildContext context, EditProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: S.of(context).profileUserName,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 16),
        TextFormField(
          onSaved: (value) {
            _name = value!.trim();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              _name = cubit.getUserModel!.name;
            } else {
              _name = value;
            }
            return null;
          },
          controller: _textEditingControllerName,
          decoration: InputDecoration(
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            hintText: S.of(context).profileUserName,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Icon(Icons.person_outline),
            suffixIcon: const Icon(Icons.edit_outlined),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
