import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/data/repo/auth_repo_impl.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view/widgets/sign_up_view_body.dart';
import 'package:flutter_e_commerce_app_2025/features/02_auth_view/presentation/view_model/auth_bloc/auth_bloc.dart';

import '../../../../core/helper/const.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepo: AuthRepoImpl()),
      child: const Scaffold(
        backgroundColor: kScaffoldColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 80)),
            SliverToBoxAdapter(child: SignUpViewBody()),
          ],
        ),
      ),
    );
  }
}
