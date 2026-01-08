import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_snack_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/edit_profile_cubit/edit_profile_state.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_button.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../../../../generated/l10n.dart';

class InputSection extends StatefulWidget {
  const InputSection({super.key});

  @override
  State<InputSection> createState() => _InputSectionState();
}

class _InputSectionState extends State<InputSection> {
  String name = '';
  String email = '';
  TextEditingController textEditingControllerName = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<EditProfileCubit>();
    textEditingControllerName.text = cubit.getUserModel!.name;
    name = cubit.getUserModel!.name;
  }

  @override
  void dispose() {
    textEditingControllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileUpdatingSuccess) {
          ToastNotification.flatColoredToastNotificationService(
            onAutoCompleteCompleted: (value) {},
            title: S.of(context).success_updateProfile_title,
            description: S.of(context).success_updateProfile_desc,
            toastNotificationType: ToastificationType.success,
          );
        } else if (state is EditProfileUpdatingFailure) {
          ToastNotification.flatColoredToastNotificationService(
            onAutoCompleteCompleted: (value) {},
            title: S.of(context).failure_updateProfile_title,
            description: S.of(context).failure_updateProfile_desc,
            toastNotificationType: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();
        return Form(
          key: formKey,
          child: Column(
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
                  name = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    name = cubit.getUserModel!.name;
                  } else {
                    name = value;
                  }
                  return null;
                },
                controller: textEditingControllerName,
                decoration: InputDecoration(
                  hintText: S.of(context).profileUserName,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(Icons.person_outline),
                  suffixIcon: const Icon(Icons.edit_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withAlpha(100),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomText(text: S.of(context).profileUserEmail, fontSize: 16),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 16,
                      children: [
                        const Icon(Icons.email_outlined),
                        CustomText(
                          text: cubit.getUserModel!.email,
                          fontSize: 16,
                        ),
                      ],
                    ),
                    const Icon(Icons.edit_off_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                isLoading: state is EditProfileLoadingData,
                textColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade600
                    : Colors.grey.shade200,
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade200
                    : kPrimaryColor,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<EditProfileCubit>().updateUserName(
                      newName: name,
                    );
                    context.read<EditProfileCubit>().saveChanges();
                  } else {
                    showSafeSnackBar(context, 'Not changed Data', Colors.grey);
                  }
                },
                text: S.of(context).profileUpdateTitleButton,
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
