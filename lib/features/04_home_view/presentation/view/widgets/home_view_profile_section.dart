import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/model/user_model.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/profile_view_custom_image.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import '../../../../../core/shimmer/home_profile_section_shimmer.dart';
import '../../../../../generated/assets.dart';
import '../../../../06_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
import '../../../../06_profile_view/presentation/view_model/user_info_cubit/user_info_state.dart';

class HomeViewProfileSection extends StatelessWidget {
  const HomeViewProfileSection({super.key});

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

          return buildDataSection(context, userModel, size, photoUrl);
        }
        // حالة الفشل
        else if (state is GetUserInfoLocalFailure ||
            state is GetUserInfoFromFirestoreFailure) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(Assets.profileDefulatProfileImage, fit: BoxFit.cover),
            ],
          );
        }

        // حالة التحميل
        return homeProfileSectionShimmer(size);
      },
    );
  }

  Row buildDataSection(
    BuildContext context,
    UserModel userModel,
    Size size,
    String? photoUrl,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: '${S.of(context).homeWelcome} ,', fontSize: 24),
            CustomText(
              text: userModel.name,
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ],
        ),
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
              : Image.asset(
                  Assets.profileDefulatProfileImage,
                  fit: BoxFit.cover,
                ),
        ),
      ],
    );
  }
}
