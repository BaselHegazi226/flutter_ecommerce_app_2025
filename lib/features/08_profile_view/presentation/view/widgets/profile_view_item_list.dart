import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_dialog_state.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/sign_out_cubit/sign_out_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/l10n.dart';
import '../../../data/model/profile_view_item_model.dart';
import 'profile_view_item.dart';

class ProfileViewItemList extends StatelessWidget {
  const ProfileViewItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        profileListFun(context).length,
        (index) => ProfileViewItem(
          iconData: profileListFun(context)[index].iconData,
          title: profileListFun(context)[index].title,
          primaryColor: profileListFun(context)[index].route == null
              ? Colors.red.withAlpha(240)
              : Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade500.withAlpha(32)
              : itemsBackgroundColor[index],
          iconColor: Colors.white,
          onTap: () {
            if (profileListFun(context)[index].route == null) {
              warningAwesomeDialog(
                context,
                title: S.of(context).profileLogoutTitle,
                description: S.of(context).profileLogoutDesc,
                buttonAcceptText: S.of(context).warning_button_title_ok,
                buttonCancelText: S.of(context).warning_button_title_Cancel,
                onPressed: () {
                  context.read<SignOutCubit>().signOut();
                  GoRouter.of(context).go(Routes.loginView);
                },
              );
            } else {
              handleProfileItemTap(
                context,
                route: profileListFun(context)[index].route!,
              );
            }
          },
        ),
      ),
    );
  }

  void handleProfileItemTap(BuildContext context, {required String route}) {
    if (route == Routes.editProfileView) {
      final cubit = context.read<UserInfoCubit>();
      GoRouter.of(context).push('${Routes.profileView}$route', extra: cubit);
    } else {
      GoRouter.of(context).push('${Routes.profileView}$route');
    }
  }

  List<ProfileViewItemModel> profileListFun(BuildContext context) {
    return [
      ProfileViewItemModel(
        route: Routes.editProfileView,
        iconData: Icons.edit,
        title: S.of(context).profileEdit,
      ),
      ProfileViewItemModel(
        route: Routes.shippingAddressView,
        iconData: Icons.location_on_outlined,
        title: S.of(context).profileShippingAddress,
      ),
      ProfileViewItemModel(
        route: Routes.favoriteView,
        iconData: Icons.favorite,
        title: S.of(context).profileFavourite,
      ),
      ProfileViewItemModel(
        route: Routes.settingsView,
        iconData: Icons.settings,
        title: S.of(context).settingsTitle,
      ),
      ProfileViewItemModel(
        route: Routes.aboutUsView,
        iconData: CupertinoIcons.globe,
        title: S.of(context).aboutMeTitle,
      ),
      ProfileViewItemModel(
        iconData: Icons.logout_outlined,
        title: S.of(context).settingsLogout,
      ),
    ];
  }

  static List<Color> itemsBackgroundColor = [
    kPrimaryColor.withAlpha(135),
    Colors.grey.withAlpha(135),
    Colors.red.withAlpha(135),
    Colors.black.withAlpha(135),
    Colors.black.withAlpha(50),
    Colors.red.withAlpha(240),
  ];
}
