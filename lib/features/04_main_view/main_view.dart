import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../core/helper/routes.dart';
import '../../core/utilities/extensions_of_s_localization.dart';
import '../../generated/l10n.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.child});

  final Widget child;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ValueNotifier<int> valueNotifierSelectedItem = ValueNotifier(0);

  final tabs = [
    Routes.homeView,
    Routes.searchView,
    Routes.cartView,
    Routes.profileView,
  ];

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
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: GNav(
        gap: 8,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade200
            : Colors.green.shade100,
        activeColor: Colors.white,
        iconSize: 20,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        tabBackgroundGradient: const LinearGradient(
          colors: [Colors.white30, Colors.white54],
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).primaryColor,
        tabBorderRadius: 16,
        style: GnavStyle.google,
        haptic: true,
        onTabChange: (index) {
          changeValueOfSelectedItem(index);
          context.go(tabs[index]);
          debugPrint(index.toString());
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: S.of(context).navHome,
            textSize: 12,
            margin: const EdgeInsetsDirectional.only(start: 6),
            padding: const EdgeInsets.all(8),
          ),
          GButton(
            icon: Icons.search_outlined,
            text: S.of(context).navSearch,
            textSize: 12,
            padding: const EdgeInsets.all(8),
          ),
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: S.of(context).navCart,
            textSize: 12,
            padding: const EdgeInsets.all(8),
          ),
          GButton(
            icon: Icons.person_2_outlined,
            text: S.of(context).navProfile,
            textSize: 12,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsetsDirectional.only(end: 6),
          ),
        ],
      ),
    );
  }

  changeValueOfSelectedItem(int currentIndex) {
    valueNotifierSelectedItem.value = currentIndex;
  }
}
