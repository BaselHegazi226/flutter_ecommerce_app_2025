import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/helper/routes.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.child});

  final Widget child;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  final tabs = const [
    Routes.homeView,
    Routes.searchView,
    Routes.cartView,
    Routes.orderHistoryView,
    Routes.profileView,
  ];

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, index, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          extendBody: true,
          body: SafeArea(bottom: true, child: widget.child),
          bottomNavigationBar: _buildGlassNavBar(context, index),
        );
      },
    );
  }

  Widget _buildGlassNavBar(BuildContext context, int currentIndex) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade700 : Colors.white.withAlpha(228),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: Colors.white24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          5,
          (index) => GestureDetector(
            onTap: () {
              _selectedIndex.value = index;
              context.go(tabs[index]);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _selectedIndex.value == index
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(32),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32),
                          ),
                        ),
                        child: Icon(
                          [
                            Icons.home_filled,
                            Icons.search,
                            Icons.shopping_cart,
                            Icons.history,
                            Icons.person,
                          ][index],
                          size: 28,
                          color: _selectedIndex.value == index
                              ? isDark
                                    ? Colors.grey.shade50
                                    : Colors.grey.shade800
                              : Colors.grey.shade400,
                        ),
                      )
                    : Icon(
                        [
                          Icons.home_outlined,
                          Icons.search,
                          Icons.shopping_cart_outlined,
                          Icons.history_outlined,
                          Icons.person_outline_outlined,
                        ][index],
                        size: 28,
                        color: _selectedIndex.value == index
                            ? isDark
                                  ? Colors.grey.shade50
                                  : Colors.grey.shade800
                            : Colors.grey.shade400,
                      ),
                SizedBox(height: _selectedIndex.value == index ? 8 : 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
//
// import '../../core/helper/routes.dart';
// import '../../core/utilities/extensions_of_s_localization.dart';
// import '../../generated/l10n.dart';
//
// class MainView extends StatefulWidget {
//   const MainView({super.key, required this.child});
//
//   final Widget child;
//
//   @override
//   State<MainView> createState() => _MainViewState();
// }
//
// class _MainViewState extends State<MainView> {
//   final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
//
//   final tabs = [
//     Routes.homeView,
//     Routes.searchView,
//     Routes.cartView,
//     Routes.profileView,
//   ];
//
//   @override
//   void dispose() {
//     _selectedIndex.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: _selectedIndex,
//       builder: (context, index, child) {
//         return Scaffold(
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           extendBody: true, // عشان الخلفية تبان تحت الـ NavBar
//           body: SafeArea(bottom: true, child: widget.child),
//           bottomNavigationBar: _buildBlurNavBar(context, index),
//         );
//       },
//     );
//   }
//
//   Widget _buildBlurNavBar(BuildContext context, int currentIndex) {
//     final size = MediaQuery.sizeOf(context);
//     final double textSize = S.of(context).navHome == 'Search'
//         ? size.width > 700
//               ? 10
//               : 8
//         : size.width > 700
//         ? 12
//         : 10;
//     return Container(
//       height: 75,
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 20,
//             offset: Offset(0, 6),
//           ),
//         ],
//       ),
//       child: GNav(
//         selectedIndex: currentIndex,
//         gap: 4,
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeInOut,
//         color: Theme.of(context).brightness == Brightness.dark
//             ? Colors.grey.shade200
//             : Colors.green.shade100,
//         activeColor: Colors.white,
//         iconSize: textSize + 10,
//         padding: EdgeInsets.zero,
//         tabBackgroundGradient: const LinearGradient(
//           colors: [Colors.white30, Colors.white54],
//         ),
//         backgroundColor: Theme.of(context).brightness == Brightness.dark
//             ? Theme.of(context).scaffoldBackgroundColor
//             : Theme.of(context).primaryColor,
//         tabBorderRadius: 16,
//         style: GnavStyle.google,
//         haptic: true,
//         onTabChange: (index) {
//           changeValueOfSelectedItem(index);
//           context.go(tabs[index]);
//         },
//         tabs: [
//           GButton(
//             icon: Icons.home_filled,
//             text: S.of(context).navHome,
//             textSize: textSize,
//             gap: 4,
//             padding: const EdgeInsets.all(8),
//             margin: const EdgeInsetsDirectional.only(start: 4),
//           ),
//           GButton(
//             icon: Icons.search_outlined,
//             text: S.of(context).navSearch,
//             textSize: textSize,
//             gap: 4,
//             padding: const EdgeInsets.all(8),
//           ),
//           GButton(
//             icon: Icons.shopping_cart,
//             text: S.of(context).navCart,
//             textSize: textSize,
//             iconSize: textSize + 12,
//             gap: 4,
//             padding: const EdgeInsets.all(8),
//           ),
//           GButton(
//             icon: Icons.person,
//             text: S.of(context).navProfile,
//             iconSize: textSize + 12,
//             textSize: textSize,
//             gap: 4,
//             padding: const EdgeInsets.all(8),
//             margin: const EdgeInsetsDirectional.only(end: 4),
//           ),
//         ],
//       ),
//     );
//   }
//
//   changeValueOfSelectedItem(int currentIndex) {
//     _selectedIndex.value = currentIndex;
//   }
// }
