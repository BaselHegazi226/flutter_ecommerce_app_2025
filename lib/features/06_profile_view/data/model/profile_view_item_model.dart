import 'package:flutter/material.dart';

class ProfileViewItemModel {
  final String? route;
  final IconData iconData;
  final String title;

  const ProfileViewItemModel({
    this.route,
    required this.iconData,
    required this.title,
  });
}
