import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view_model/edit_profile_cubit/edit_profile_state.dart';

import 'edit_profile_image_section.dart';
import 'edit_profile_input_section.dart';

class EditDataSection extends StatelessWidget {
  const EditDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            final cubit = context.read<EditProfileCubit>();
            if (state is EditProfileDataUpdating) {
              return ImageSection(
                imageUrl: state.userModel.photoUrl,
                onPressed: () {
                  context.read<EditProfileCubit>().prepareImageToUpload();
                },
              );
            } else if (state is EditProfileUpdatingSuccess) {
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
    );
  }
}
