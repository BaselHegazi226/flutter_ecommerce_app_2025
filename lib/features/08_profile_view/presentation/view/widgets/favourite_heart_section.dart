import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/icon_with_circle_style.dart';

class FavouriteHeartSection extends StatelessWidget {
  const FavouriteHeartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return IconWithCircleStyle(
      backgroundColor: Colors.grey.shade400.withAlpha(32),
      icon: Icon(
        Icons.favorite_outlined,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.red.shade500,
        size: 18,
      ),
      onPressed: () {},
    );
  }
}
