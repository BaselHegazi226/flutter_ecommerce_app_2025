import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/repo/auth_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_in_view_body.dart';

import '../view_model/auth_bloc/auth_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepo: AuthRepoImpl()),
      child: Scaffold(
        backgroundColor: kScaffoldColor,
        body: const CustomScrollView(
          slivers: [SliverToBoxAdapter(child: SignInViewViewBody())],
        ),
      ),
    );
  }
}
