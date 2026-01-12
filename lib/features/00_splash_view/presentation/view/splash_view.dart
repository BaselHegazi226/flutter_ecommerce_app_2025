import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/show_snack_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../generated/assets.dart';
import '../../../03_auth_view/data/repo/auth_repo_impl.dart';
import '../../../03_auth_view/presentation/view_model/is_new_user_cubit/is_new_user_cubit.dart';
import '../../../03_auth_view/presentation/view_model/is_new_user_cubit/is_new_user_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;

  bool _canNavigate = false; // يمنع الانتقال لحد ما الأنيميشن يخلص
  IsNewUserState? _latestState; // نحتفظ بآخر حالة من الـ Cubit

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), // سرعة متوسطة
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _blurAnimation = Tween<double>(
      begin: 8,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    /// ⏱️ خلي الصفحة ظاهرة واللوجو مختفي (للمعاينة: دقيقة)
    /// بعد ما تخلص اختبارك ارجعها لـ seconds: 1 أو 2
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      _controller.forward();
    });

    /// بعد انتهاء الأنيميشن نسمح بالتنقل
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _canNavigate = true;
        _tryNavigate(); // لو الحالة كانت جاهزة بالفعل
      }
    });
  }

  void _tryNavigate() {
    if (!_canNavigate || _latestState == null) return;

    if (_latestState is IsNewUserSuccess) {
      GoRouter.of(context).go(Routes.languageView);
    } else if (_latestState is IsOldUser) {
      GoRouter.of(context).go(Routes.homeView);
    } else if (_latestState is IsNewUserFailure) {
      final s = _latestState as IsNewUserFailure;
      showSafeSnackBar(context, s.errorMessage, kPrimaryWrongColor);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            IsNewUserCubit(authRepo: AuthRepoImpl())..isNewUser(),
        child: BlocListener<IsNewUserCubit, IsNewUserState>(
          listener: (context, state) {
            // نخزّن الحالة، لكن ما نعملش Navigation إلا لما الأنيميشن يخلص
            _latestState = state;
            _tryNavigate();
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// ✨ اللوجو بأنيميشن (غبار → ظهور)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: _blurAnimation.value,
                            sigmaY: _blurAnimation.value,
                          ),
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: Theme.of(context).brightness == Brightness.dark
                      ? Image.asset(Assets.splashAppLogoDark, height: 250)
                      : Image.asset(Assets.splashAppLogoLight, height: 250),
                ),

                const SizedBox(height: 20),

                /// ⏳ اللودينج أثناء فحص المستخدم
                BlocBuilder<IsNewUserCubit, IsNewUserState>(
                  builder: (context, state) {
                    if (state is IsNewUserLoading) {
                      return LoadingAnimationWidget.progressiveDots(
                        color: Theme.of(context).primaryColor,
                        size: 50,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
