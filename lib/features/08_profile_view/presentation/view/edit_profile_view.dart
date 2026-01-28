import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_loading_indicator.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/domain/use_cases/profile_use_cases.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view/widgets/edit_profile_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/update_profile_cubit/update_profile_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/update_user_name_cubit/update_user_name_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/user_info_cubit/user_info_state.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utilities/custom_text.dart';
import '../view_model/update_image_cubit/update_image_cubit.dart';
import '../view_model/user_info_cubit/user_info_cubit.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.userInfoCubit});

  final UserInfoCubit userInfoCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateProfileCubit(
            AppGet().getIt<UpdateProfileUseCase>(),
            userInfoCubit,
          ),
        ),
        BlocProvider(
          create: (_) => UpdateImageCubit(
            AppGet().getIt<UploadImageToCloudniaryUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => UpdateUserNameCubit(
            AppGet().getIt<ChangeCurrentUserNameUseCase>(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: customAppBar(
          context,
          S.of(context).profileEdit,
          () => GoRouter.of(context).pop(),
        ),
        body: BlocBuilder<UserInfoCubit, UserInfoState>(
          builder: (context, state) {
            // حالة النجاح سواء من الكاش أو من الفايرستور
            if (state is GetUserInfoLocalSuccess ||
                state is GetUserInfoFromFirestoreSuccess) {
              final userModel = state is GetUserInfoLocalSuccess
                  ? state.userModel
                  : (state as GetUserInfoFromFirestoreSuccess).userModel;

              final photoUrl = userModel.photoUrl;

              return EditProfileViewBody(
                userName: userModel.name,
                photoUrl: photoUrl,
                userEmail: userModel.email,
              );
            }
            // حالة الفشل
            else if (state is GetUserInfoLocalFailure ||
                state is GetUserInfoFromFirestoreFailure) {
              final errorMessage = state is GetUserInfoLocalFailure
                  ? state.errorMessage
                  : (state as GetUserInfoFromFirestoreFailure).errorMessage;
              return Center(
                child: CustomText(
                  text: errorMessage,
                  fontSize: 18,
                  alignment: Alignment.center,
                ),
              );
            }
            return const CustomCircleIndicator();
          },
        ),
      ),
    );
  }
}
