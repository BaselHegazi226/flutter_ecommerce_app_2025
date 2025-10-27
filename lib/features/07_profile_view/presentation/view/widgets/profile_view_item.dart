import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

class ProfileViewItem extends StatelessWidget {
  const ProfileViewItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
  });
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xffEDFBF4),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Icon(iconData, size: 24, color: Colors.black),
        ),
        title: CustomText(
          text: title,
          fontSize: 18,
          alignment: Alignment.centerLeft,
        ),
        trailing: title == 'Logout'
            ? null
            : const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
                color: Colors.black,
              ),
      ),
    );
  }
}
