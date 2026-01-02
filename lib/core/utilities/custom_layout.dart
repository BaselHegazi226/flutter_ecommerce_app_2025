import 'package:flutter/material.dart';

class CustomGridLayout extends StatelessWidget {
  const CustomGridLayout({
    super.key,
    required this.mobileWidget,
    required this.tabletWidget,
  });
  final Widget mobileWidget, tabletWidget;
  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        if (constraints.crossAxisExtent >= 600) {
          return tabletWidget;
        } else {
          return mobileWidget;
        }
      },
    );
  }
}

class CustomLayout extends StatelessWidget {
  const CustomLayout({
    super.key,
    required this.mobileWidget,
    required this.tabletWidget,
  });
  final Widget mobileWidget, tabletWidget;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return tabletWidget;
        } else {
          return mobileWidget;
        }
      },
    );
  }
}
