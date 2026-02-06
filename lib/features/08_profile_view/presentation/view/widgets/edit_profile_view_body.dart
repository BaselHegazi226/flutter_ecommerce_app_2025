import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/profile_header_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/toastnotification.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view/widgets/profile_view_custom_image.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/update_image_cubit/update_image_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/update_profile_cubit/update_profile_state.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/utilities/custom_button.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/update_profile_cubit/update_profile_cubit.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({
    super.key,
    required this.userName,
    required this.photoUrl,
    required this.userEmail,
  });

  final String? photoUrl;
  final String userEmail, userName;

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userName;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          ToastNotification.flatColoredToastNotificationService(
            onAutoCompleteCompleted: (value) {},
            title: S.of(context).success_updateProfile_title,
            description: S.of(context).success_updateProfile_desc,
            toastNotificationType: ToastificationType.success,
          );
        } else if (state is UpdateProfileFailure) {
          ToastNotification.flatColoredToastNotificationService(
            onAutoCompleteCompleted: (value) {},
            title: S.of(context).failure_updateProfile_title,
            description: S.of(context).failure_updateProfile_desc,
            toastNotificationType: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        return buildDataSection(
          size,
          imageUrl: (state is UpdateProfileSuccess)
              ? state.updatedUser.photoUrl
              : widget.photoUrl,
          userName: (state is UpdateProfileSuccess)
              ? state.updatedUser.name
              : widget.userName,
          userEmail: widget.userEmail,
          isLoadingButton: state is UpdateProfileLoading,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              final imageState = context.read<UpdateImageCubit>().state;

              context.read<UpdateProfileCubit>().updateProfile(
                userName: nameController.text,
                imageUrl: imageState is UpdateImageSuccess
                    ? imageState.imageUrl
                    : widget.photoUrl,
              );
            }
          },
        );
      },
    );
  }

  Widget buildDataSection(
    Size size, {
    String? imageUrl,
    required String userName,
    required String userEmail,
    required void Function()? onPressed,
    required bool isLoadingButton,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildImageSection(imageUrl: imageUrl, size: size),
                  const SizedBox(height: 24),
                  buildUserNameSection(context, userName),
                  const SizedBox(height: 32),
                  _buildUserEmailField(context, userEmail),

                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
          CustomButton(
            isLoading: isLoadingButton,
            text: S.of(context).profileEditSave,
            textColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade600
                : Colors.grey.shade200,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade200
                : kPrimaryColor,
            textSize: 18,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  Form buildUserNameSection(BuildContext context, String name) {
    return Form(
      key: _formKey,
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
            controller: nameController,
            decoration: InputDecoration(
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              prefixIcon: const Icon(Icons.person, color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return S.of(context).authNameRequired;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserEmailField(BuildContext context, String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: S.of(context).profileUserEmail,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: kGreyColor),
          ),
          child: Row(
            children: [
              const Icon(Icons.email, color: Colors.grey),
              const SizedBox(width: 16),
              Expanded(
                child: CustomText(text: email, fontSize: 16, maxLines: 1),
              ),
              const Icon(Icons.lock_outline, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection({
    String? imageUrl,
    bool failed = false,
    required Size size,
  }) {
    return BlocConsumer<UpdateImageCubit, UpdateImageState>(
      listener: (context, state) {
        if (state is UpdateImageSuccess) {
          ToastNotification.flatColoredToastNotificationService(
            onAutoCompleteCompleted: (_) {},
            title: S.of(context).success_selected_Image_title,
            description: S.of(context).success_selected_Image_desc,
            toastNotificationType: ToastificationType.success,
          );
        } else if (state is UpdateImageFailure) {
          ToastNotification.flatColoredToastNotificationService(
            onAutoCompleteCompleted: (_) {},
            title: S.of(context).failure_selected_Image_title,
            description: S.of(context).failure_selected_Image_desc,
            toastNotificationType: ToastificationType.warning,
          );
        }
      },
      builder: (context, state) {
        if (state is UpdateImageSuccess) {
          return CustomImage(
            imageSize: size.width * .35,
            imageProvider: state.imageUrl.contains('http')
                ? CachedNetworkImage(imageUrl: state.imageUrl)
                : Image.asset(Assets.profileDefulatProfileImage),
          );
        } else if (state is UpdateImageFailure) {
          if (imageUrl == null) {
            return Image.asset(Assets.profileDefulatProfileImage);
          } else {
            return CachedNetworkImage(imageUrl: imageUrl);
          }
        }
        final String? imageShowed = (state is UpdateImageSuccess)
            ? state.imageUrl
            : imageUrl;
        return state is UpdateImageLoading
            ? editProfileImageShimmer(size)
            : Stack(
                children: [
                  failed
                      ? const Icon(Icons.image_not_supported_outlined, size: 40)
                      : CustomImage(
                          imageSize: size.width * .35,
                          imageProvider:
                              imageShowed != null &&
                                  imageShowed.contains('http')
                              ? CachedNetworkImage(imageUrl: imageShowed)
                              : Image.asset(Assets.profileDefulatProfileImage),
                        ),
                  Positioned(
                    bottom: size.width * 0.025,
                    right: size.width * 0.01,
                    child: GestureDetector(
                      onTap: () {
                        context.read<UpdateImageCubit>().pickUploadImage();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade200
                              : Colors.grey.shade800,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: size.width * 0.055,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade900
                              : Colors.grey.shade50,
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
