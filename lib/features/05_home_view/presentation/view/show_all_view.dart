import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/05_home_view/presentation/view/widgets/show_all_view_body.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utilities/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../view_model/show_all_cubit/show_all_cubit.dart';

class ShowAllView extends StatelessWidget {
  const ShowAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowAllCubit()..showAllProduct(),

      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: customAppBar(context, S.of(context).homeAllProducts, () {
          GoRouter.of(context).pop();
        }),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: ShowAllViewBody(),
        ),
      ),
    );
  }
}
