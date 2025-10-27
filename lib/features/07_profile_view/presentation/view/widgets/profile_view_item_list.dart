import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/routes.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_dialog_state.dart';
import 'package:flutter_e_commerce_app_2025/features/07_profile_view/presentation/view/widgets/profile_view_item.dart';
import 'package:flutter_e_commerce_app_2025/features/07_profile_view/presentation/view_model/user_info_cubit/user_info_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../data/model/profile_view_item_model.dart';

class ProfileViewItemList extends StatelessWidget {
  const ProfileViewItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        list.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ProfileViewItem(
            iconData: list[index].iconData,
            title: list[index].title,
            onTap: () {
              if (list[index].id == 6) {
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
                handleProfileItemTap(context, id: list[index].id);
              }
            },
          ),
        ),
      ),
    );
  }

  void handleProfileItemTap(BuildContext context, {required int id}) {
    switch (id) {
      case 1:
        debugPrint('Edit profile');
        break;
      case 2:
        debugPrint('Shipping Address');
        break;
      case 3:
        debugPrint('Order History');
        break;
      case 4:
        debugPrint('Cards');
        break;
      case 5:
        debugPrint('Notifications');
        break;
    }
  }

  static const List<ProfileViewItemModel> list = [
    ProfileViewItemModel(id: 1, iconData: Icons.edit, title: 'Edit Profile'),
    ProfileViewItemModel(
      id: 2,
      iconData: Icons.location_on_outlined,
      title: 'Shipping Address',
    ),
    ProfileViewItemModel(
      id: 3,
      iconData: Icons.history,
      title: 'Order History',
    ),
    ProfileViewItemModel(
      id: 4,
      iconData: Icons.credit_card_outlined,
      title: 'Cards',
    ),
    ProfileViewItemModel(
      id: 5,
      iconData: Icons.notifications_active_outlined,
      title: 'Notifications',
    ),
    ProfileViewItemModel(
      id: 6,
      iconData: Icons.logout_outlined,
      title: 'Logout',
    ),
  ];
}
