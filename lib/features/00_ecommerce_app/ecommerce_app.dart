import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toastification/toastification.dart';

import '../../core/utilities/app_router.dart';
import '../../core/utilities/theme_app.dart';
import '../../generated/l10n.dart';
import '../05_cart_view/presentation/view_model/payment_bloc/payment_bloc.dart';
import '../06_profile_view/presentation/view_model/settings_cubit/settings_cubit.dart';
import '../06_profile_view/presentation/view_model/settings_cubit/settings_state.dart';

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
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,

              // ===== أنيميشن لتغيير الثيم أو اللغة =====
              themeAnimationDuration: const Duration(milliseconds: 400),
              themeAnimationCurve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}
