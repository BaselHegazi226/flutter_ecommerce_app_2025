import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_dialog_state.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/profile_view_item.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/l10n.dart';
import '../../../data/model/profile_view_item_model.dart';
import '../../view_model/user_info_cubit/user_info_cubit.dart';

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
                title: 'Sign Out',
                description: 'Are You Sure To Sign Out?',
                buttonAcceptText: 'Ok',
                buttonCancelText: 'Cancel',
                onPressed: () {
                  context.read<UserInfoCubit>().signOut();
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
      // جلب بيانات المستخدم من الـ Cubit الحالي
      //final state = context.read<UserInfoCubit>().state;
      // UserModel? currentUser;
      // if (state is GetUserInfoLocalSuccess) {
      //   currentUser = state.userModel;
      // } else if (state is GetUserInfoFromFirestoreSuccess) {
      //   currentUser = state.userModel;
      // }
      //
      // if (currentUser != null) {
      //   GoRouter.of(context).push(
      //     '${Routes.profileView}$route',
      //     extra: cubit, // ← تمرير UserModel هنا
      //   );
      // }
      final cubit = context.read<UserInfoCubit>();
      GoRouter.of(context).push(
        '${Routes.profileView}$route',
        extra: cubit, // ← تمرير UserModel هنا
      );
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
        route: Routes.orderHistoryView,
        iconData: Icons.history,
        title: S.of(context).orderHistory,
      ),
      ProfileViewItemModel(
        route: Routes.favoriteView,
        iconData: Icons.favorite_outline,
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
    Colors.orange.withAlpha(135),
    Colors.red.withAlpha(135),
    Colors.black.withAlpha(135),
    Colors.black.withAlpha(50),
    Colors.red.withAlpha(240),
  ];
}
