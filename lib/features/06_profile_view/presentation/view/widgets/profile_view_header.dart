import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/shimmer/profile_header_shimmer.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/profile_view_custom_image.dart';

import '../../../../../generated/assets.dart';
import '../../view_model/user_info_cubit/user_info_cubit.dart';
import '../../view_model/user_info_cubit/user_info_state.dart';

class ProfileViewHeader extends StatelessWidget {
  const ProfileViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        // حالة النجاح سواء من الكاش أو من الفايرستور
        if (state is GetUserInfoLocalSuccess ||
            state is GetUserInfoFromFirestoreSuccess) {
          final userModel = state is GetUserInfoLocalSuccess
              ? state.userModel
              : (state as GetUserInfoFromFirestoreSuccess).userModel;

          final photoUrl = userModel.photoUrl;

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImage(
                imageWidth: size.width * .2,
                child: photoUrl != null && photoUrl.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: photoUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, widget) {
                          return const Icon(Icons.image_not_supported_outlined);
                        },
                      )
                    : Image.asset(Assets.profileDefulatProfileImage),
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomText(
                      text: userModel.name,
                      maxLines: 2,
                      fontSize: 20,
                      alignment: Alignment.center,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade200
                          : Colors.black,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomText(
                      text: userModel.email,
                      fontSize: 14,
                      alignment: Alignment.center,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade200
                          : Colors.black.withAlpha(180),
                    ),
                  ),
                ],
              ),
            ],
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

        // حالة التحميل
        return const ProfileHeaderShimmer();
      },
    );
  }
}
