import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view/widgets/about_us_view_body.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, S.of(context).about_me_title, () {
          GoRouter.of(context).pop();
        }),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: AboutUsViewBody(),
          ),
        ),
      ),
    );
  }
}
