import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_layout.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

import '../../../../../generated/l10n.dart';

class ProfileViewItem extends StatelessWidget {
  const ProfileViewItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
    required this.primaryColor,
    this.iconColor = Colors.white,
    this.textColor = Colors.black,
    this.arrowColor = Colors.black,
  });

  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  final Color primaryColor;
  final Color iconColor;
  final Color textColor;
  final Color arrowColor;

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      mobileWidget: ProfileViewItemMobile(
        iconData: iconData,
        title: title,
        onTap: onTap,
        primaryColor: primaryColor,
        iconColor: iconColor,
        arrowColor: arrowColor,
      ),
      tabletWidget: ProfileViewItemTablet(
        iconData: iconData,
        title: title,
        onTap: onTap,
        primaryColor: primaryColor,
        iconColor: iconColor,
        arrowColor: arrowColor,
      ),
    );
  }
}

class ProfileViewItemMobile extends StatelessWidget {
  const ProfileViewItemMobile({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
    required this.primaryColor,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
    this.arrowColor = Colors.black,
  });

  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  final Color primaryColor;
  final Color iconColor;
  final Color textColor;
  final Color arrowColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Icon(iconData, size: 24, color: iconColor),
        ),
        title: CustomText(text: title, fontSize: 18, color: textColor),
        trailing: title == S.of(context).settingsLogout
            ? null
            : const Icon(Icons.arrow_forward_ios_outlined, size: 20),
      ),
    );
  }
}

class ProfileViewItemTablet extends StatelessWidget {
  const ProfileViewItemTablet({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
    required this.primaryColor,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
    this.arrowColor = Colors.black,
  });

  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  final Color primaryColor;
  final Color iconColor;
  final Color textColor;
  final Color arrowColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 16,
            children: [
              Container(
                height: 72,
                width: 72,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(iconData, size: 28, color: iconColor),
              ),
              CustomText(text: title, fontSize: 18, color: textColor),
            ],
          ),
          ?title != S.of(context).settingsLogout
              ? const Icon(Icons.arrow_forward_ios_outlined, size: 24)
              : null,
        ],
      ),
    );
  }
}
