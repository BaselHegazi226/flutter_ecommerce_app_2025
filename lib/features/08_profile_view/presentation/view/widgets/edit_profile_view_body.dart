import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/edit_profile_cubit/edit_profile_cubit.dart';
import '../../view_model/edit_profile_cubit/edit_profile_state.dart';
import 'edit_profile_image_section.dart';
import 'edit_profile_input_section.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
                } else if (state is EditProfileSuccess) {
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
            const SizedBox(height: 24),
            const InputSection(),
          ],
        ),
      ),
    );
  }
}
