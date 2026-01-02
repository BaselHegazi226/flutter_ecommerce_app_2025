import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/cache/favourite_cache.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/app_get.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:flutter_e_commerce_app_2025/features/04_home_view/presentation/view_model/favourite_product_cubit/favourite_product_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/favourite_view_body.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteProductCubit(
        favouriteCache: AppGet().getIt<FavouriteCacheImplement>(),
      )..getFavouriteProducts(),
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(context, S.of(context).profileFavourite, () {
            GoRouter.of(context).pop();
          }),
          body: const FavouriteViewBody(),
        ),
      ),
    );
  }
}
