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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBody: true,
        body: widget.child, // المحتوى بيتغير حسب الـ route
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: _selectedIndex,
          builder: (context, index, _) {
            return _buildBlurNavBar(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildBlurNavBar(BuildContext context, int currentIndex) {
    final size = MediaQuery.sizeOf(context);
    final double textSize = size.width > 700 ? 12 : 10;

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
        // <-- ربطه بالـ ValueNotifier
        gap: 4,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade200
            : Colors.green.shade100,
        activeColor: Colors.white,
        iconSize: textSize + 8,
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
          if (index == _selectedIndex.value) return;

          _selectedIndex.value = index;
          context.go(tabs[index]); // التنقل
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: S.of(context).navHome,
            textSize: textSize,
            gap: 4,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsetsDirectional.only(start: 2),
          ),
          GButton(
            icon: Icons.search_outlined,
            text: S.of(context).navSearch,
            textSize: textSize,
            gap: 4,
            padding: const EdgeInsets.all(8),
          ),
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: S.of(context).navCart,
            textSize: textSize,
            gap: 4,
            padding: const EdgeInsets.all(8),
          ),
          GButton(
            icon: Icons.person_2_outlined,
            text: S.of(context).navProfile,
            textSize: textSize,
            gap: 4,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsetsDirectional.only(end: 2),
          ),
        ],
      ),
    );
  }
}
