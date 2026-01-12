import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  ValueNotifier<int> valueNotifierSelectedItem = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifierSelectedItem,
      builder: (context, value, child) {
        return BottomNavigationBar(
          elevation: 4,
          backgroundColor: kScaffoldColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: valueNotifierSelectedItem.value,
          onTap: (index) {
            changeValueOfSelectedItem(index);
          },
          items: [
            customBottomNavBarItem(
              iconData: Icons.explore_outlined,
              text: 'Explore',
            ),
            customBottomNavBarItem(
              iconData: Icons.shopping_basket_outlined,
              text: 'Shopping',
            ),
            customBottomNavBarItem(
              iconData: Icons.person_2_outlined,
              text: 'Profile',
            ),
          ],
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
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
      label: '',
    );
  }
}
