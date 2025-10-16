import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:go_router/go_router.dart';

import '../../core/helper/routes.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.child});
  final Widget child;
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ValueNotifier<int> valueNotifierSelectedItem = ValueNotifier(0);

  final tabs = [Routes.homeView, Routes.cartView, Routes.accountView];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifierSelectedItem,
      builder: (context, index, child) {
        return Scaffold(
          backgroundColor: kScaffoldColor,
          body: widget.child,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 4,
            backgroundColor: kScaffoldColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: valueNotifierSelectedItem.value,
            onTap: (index) {
              changeValueOfSelectedItem(index);
              context.go(tabs[index]);
              debugPrint(index.toString());
            },
            items: [
              customBottomNavBarItem(
                iconData: Icons.explore_outlined,
                text: 'Explore',
              ),
              customBottomNavBarItem(
                iconData: Icons.shopping_cart_outlined,
                text: 'Shopping',
              ),
              customBottomNavBarItem(
                iconData: Icons.person_2_outlined,
                text: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  changeValueOfSelectedItem(int currentIndex) {
    valueNotifierSelectedItem.value = currentIndex;
  }

  customBottomNavBarItem({required IconData iconData, required String text}) {
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: Colors.black),
      activeIcon: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(4),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(8),
          child: CustomText(
            text: text,
            fontSize: 14,
            color: Colors.black,
            alignment: Alignment.center,
          ),
        ),
      ),
      label: '',
    );
  }
}
