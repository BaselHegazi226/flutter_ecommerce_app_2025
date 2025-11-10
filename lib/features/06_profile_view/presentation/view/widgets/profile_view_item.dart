import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

class ProfileViewItem extends StatelessWidget {
  const ProfileViewItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
    required this.primaryColor,
  });
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: primaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Icon(iconData, size: 24, color: primaryColor),
        ),
        title: CustomText(
          text: title,
          fontSize: 18,
          alignment: Alignment.centerLeft,
          color: primaryColor,
        ),
        trailing: title == 'Logout'
            ? null
            : Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
                color: primaryColor,
              ),
      ),
    );
  }
}
