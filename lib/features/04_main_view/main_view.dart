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
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  final tabs = [
    Routes.homeView,
    Routes.searchView,
    Routes.cartView,
    Routes.profileView,
  ];

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, index, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          extendBody: true, // عشان الخلفية تبان تحت الـ NavBar
          body: SafeArea(bottom: true, child: widget.child),
          bottomNavigationBar: _buildBlurNavBar(context, index),
        );
      },
    );
  }

  Widget _buildBlurNavBar(BuildContext context, int currentIndex) {
    final size = MediaQuery.sizeOf(context);
    final double textSize = S.of(context).navHome == 'Search'
        ? size.width > 700
              ? 10
              : 8
        : size.width > 700
        ? 12
        : 10;
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
        selectedIndex: currentIndex,
        gap: 4,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade200
            : Colors.green.shade100,
        activeColor: Colors.white,
        iconSize: textSize + 10,
        padding: EdgeInsets.zero,
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
        },
        tabs: [
          GButton(
            icon: Icons.home_filled,
            text: S.of(context).navHome,
            textSize: textSize,
            gap: 4,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsetsDirectional.only(start: 4),
          ),
          GButton(
            icon: Icons.search_outlined,
            text: S.of(context).navSearch,
            textSize: textSize,
            gap: 4,
            padding: const EdgeInsets.all(8),
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: S.of(context).navCart,
            textSize: textSize,
            iconSize: textSize + 12,
            gap: 4,
            padding: const EdgeInsets.all(8),
          ),
          GButton(
            icon: Icons.person,
            text: S.of(context).navProfile,
            iconSize: textSize + 12,
            textSize: textSize,
            gap: 4,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsetsDirectional.only(end: 4),
          ),
        ],
      ),
    );
  }

  changeValueOfSelectedItem(int currentIndex) {
    _selectedIndex.value = currentIndex;
  }
}
