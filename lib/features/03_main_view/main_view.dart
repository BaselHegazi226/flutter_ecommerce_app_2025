import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../core/helper/routes.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.child});
  final Widget child;
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ValueNotifier<int> valueNotifierSelectedItem = ValueNotifier(0);

  final tabs = [Routes.homeView, Routes.cartView, Routes.profileView];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifierSelectedItem,
      builder: (context, index, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: widget.child,
          extendBody: true, // عشان الخلفية تبان تحت الـ NavBar
          bottomNavigationBar: _buildBlurNavBar(context),
        );
      },
    );
  }

  Widget _buildBlurNavBar(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: GNav(
        gap: 8,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade200
            : Colors.green.shade100,
        activeColor: Colors.white,
        iconSize: 26,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        tabBackgroundGradient: const LinearGradient(
          colors: [Colors.white30, Colors.white54],
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).primaryColor,
        tabBorderRadius: 16,
        haptic: true,
        onTabChange: (index) {
          changeValueOfSelectedItem(index);
          context.go(tabs[index]);
          debugPrint(index.toString());
        },
        tabs: const [
          GButton(
            margin: EdgeInsets.only(left: 8),
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(icon: Icons.shopping_cart_outlined, text: 'Cart'),
          GButton(
            margin: EdgeInsets.only(right: 8),
            icon: Icons.person_2_outlined,
            text: 'Profile',
          ),
        ],
      ),
    );
  }

  changeValueOfSelectedItem(int currentIndex) {
    valueNotifierSelectedItem.value = currentIndex;
  }
}
