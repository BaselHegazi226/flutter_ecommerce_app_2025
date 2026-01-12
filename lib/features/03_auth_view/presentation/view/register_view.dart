import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/03_auth_view/presentation/view/widgets/register_view_body.dart';

import '../../data/repo/auth_repo_impl.dart';
import '../view_model/auth_bloc/auth_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepo: AuthRepoImpl()),
      child: const Scaffold(
        body: CustomScrollView(
          slivers: [SliverToBoxAdapter(child: RegisterViewBody())],
        ),
      ),
    );
  }
}
