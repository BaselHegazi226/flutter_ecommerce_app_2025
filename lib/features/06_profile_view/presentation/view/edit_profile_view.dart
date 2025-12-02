import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_snack_bar.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/profile_view_custom_image.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/edit_profile_cubit/edit_profile_state.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/const.dart';
import '../../../../core/utilities/custom_button.dart';
import '../../../../core/utilities/custom_text.dart';
import '../../../../generated/l10n.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.userInfoCubit});
  final UserInfoCubit userInfoCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditProfileCubit(userInfoCubit: userInfoCubit)..getCurrentUserData(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: customAppBar(context, 'Edit Profile', () {
          GoRouter.of(context).pushReplacement(Routes.profileView);
        }),
        body: const CustomScrollView(
          slivers: [SliverToBoxAdapter(child: EditProfileViewBody())],
        ),
      ),
    );
  }
}

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              final cubit = context.read<EditProfileCubit>();
              if (state is EditProfileDataUpdating) {
                debugPrint('image = ${state.userModel.photoUrl}');
                debugPrint('name = ${state.userModel.name}');
                return ImageSection(
                  imageUrl: state.userModel.photoUrl,
                  onPressed: () {
                    context.read<EditProfileCubit>().prepareImageToUpload();
                  },
                );
              } else if (state is EditProfileUpdatingSuccess) {
                debugPrint('image = ${state.updatedUserModel.photoUrl}');
                debugPrint('name = ${state.updatedUserModel.name}');
                return ImageSection(
                  imageUrl: state.updatedUserModel.photoUrl,
                  onPressed: () {
                    context.read<EditProfileCubit>().prepareImageToUpload();
                  },
                );
              }
              return ImageSection(
                imageUrl: cubit.getUserModel?.photoUrl,
                onPressed: () {
                  context.read<EditProfileCubit>().prepareImageToUpload();
                },
              );
            },
          ),
          const InputSection(),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
    required this.imageUrl,
    required this.onPressed,
  });
  final String? imageUrl;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomImage(
          enableBorder: false,
          child: imageUrl != null && imageUrl!.length > 100
              ? Image.memory(base64Decode(imageUrl!))
              : imageUrl != null && imageUrl!.contains('http')
              ? CachedNetworkImage(imageUrl: imageUrl!)
              : Image.asset(Assets.profileDefulatProfileImage),
        ),
        Positioned(
          bottom: size.width * 0.06,
          right: size.width * 0.02,
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.camera_alt_outlined, size: size.width * 0.055),
            ),
          ),
        ),
      ],
    );
  }
}

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
  void dispose() {
    textEditingControllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileUpdatingSuccess) {
          debugPrint('updated profile Successfully');
        } else if (state is EditProfileUpdatingFailure) {
          debugPrint('updated profile Successfully');
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();
        textEditingControllerName.text = cubit.getUserModel!.name;
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: S.of(context).UserName,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                alignment: S.of(context).UserName == 'User Name'
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
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
                decoration: const InputDecoration(
                  hintText: 'User Name',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kGreyColor,
                  ),
                  prefixIcon: Icon(Icons.person_outline),
                  suffixIcon: Icon(Icons.edit_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreyColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomText(
                text: S.of(context).UserEmail,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                alignment: S.of(context).UserEmail == 'User Email'
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
              ),
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
              const SizedBox(height: 64),
              CustomButton(
                isLoading: state is EditProfileLoadingData,
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
                text: 'Update Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
