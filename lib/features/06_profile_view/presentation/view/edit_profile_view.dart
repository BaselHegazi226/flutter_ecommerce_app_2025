import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, S.of(context).EditProfile, () {
          GoRouter.of(context).pushReplacement(Routes.profileView);
        }),
      ),
    );
  }
}
