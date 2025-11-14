import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_dialog_state.dart';
import 'package:flutter_e_commerce_app_2025/features/06_profile_view/presentation/view/widgets/profile_view_item.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/const.dart';
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
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ProfileViewItem(
            iconData: profileListFun(context)[index].iconData,
            title: profileListFun(context)[index].title,
            primaryColor: profileListFun(context)[index].route == null
                ? Colors.red
                : Theme.of(context).brightness == Brightness.dark
                ? const Color(0xffEDFBF4)
                : kPrimaryColor,
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
      ),
    );
  }

  void handleProfileItemTap(BuildContext context, {required String route}) {
    GoRouter.of(context).push('${Routes.profileView}$route');
  }

  List<ProfileViewItemModel> profileListFun(BuildContext context) {
    return [
      ProfileViewItemModel(
        route: Routes.editProfileView,
        iconData: Icons.edit,
        title: S.of(context).EditProfile,
      ),
      ProfileViewItemModel(
        route: Routes.shippingAddressView,
        iconData: Icons.location_on_outlined,
        title: S.of(context).ShippingAddress,
      ),
      ProfileViewItemModel(
        route: Routes.orderHistoryView,
        iconData: Icons.history,
        title: S.of(context).OrderHistory,
      ),
      ProfileViewItemModel(
        route: Routes.favoriteView,
        iconData: Icons.favorite_outline,
        title: S.of(context).Favourite,
      ),
      ProfileViewItemModel(
        route: Routes.settingsView,
        iconData: Icons.settings,
        title: S.of(context).Settings,
      ),
      ProfileViewItemModel(
        iconData: Icons.logout_outlined,
        title: S.of(context).Logout,
      ),
    ];
  }
}
