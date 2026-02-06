import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/domain/use_cases/profile_use_cases.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/sign_out_cubit/sign_out_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toastification/toastification.dart';

import '../../core/utilities/app_get.dart';
import '../../core/utilities/app_router.dart';
import '../../core/utilities/theme_app.dart';
import '../../generated/l10n.dart';
import '../07_cart_view/presentation/view_model/payment_bloc/payment_bloc.dart';
import '../08_profile_view/data/repo_impl/profile_repo_impl.dart';
import '../08_profile_view/presentation/view_model/settings_cubit/settings_cubit.dart';
import '../08_profile_view/presentation/view_model/settings_cubit/settings_state.dart';

class EcommerceApp extends StatelessWidget {
  final String? savedTheme;
  final String? savedLanguage;

  const EcommerceApp({super.key, this.savedTheme, this.savedLanguage});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppSettingCubit(
              savedTheme: savedTheme,
              savedLanguage: savedLanguage,
            ),
          ),
          BlocProvider(create: (context) => PaymentBloc()),
          // UserInfoCubit عالمي
          BlocProvider(
            create: (context) =>
                UserInfoCubit(AppGet().getIt<ProfileRepoImpl>())..getUserInfo(),
          ),
          BlocProvider(
            create: (context) => SignOutCubit(AppGet().getIt<SignOutUseCase>()),
          ),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingStates>(
          builder: (context, state) {
            final appSettingCubit = AppSettingCubit.get(context);

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,

              // ===== اللغة =====
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale(appSettingCubit.getLanguage()),

              // ===== الثيم =====
              themeMode: appSettingCubit.getTheme(),
              theme: AppTheme.lightTheme(appSettingCubit.getLanguage()),
              darkTheme: AppTheme.darkTheme(appSettingCubit.getLanguage()),

              // ===== أنيميشن =====
              themeAnimationDuration: const Duration(milliseconds: 400),
              themeAnimationCurve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}
