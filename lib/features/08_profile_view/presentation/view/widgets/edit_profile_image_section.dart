import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/features/08_profile_view/presentation/view/widgets/profile_view_custom_image.dart';
import 'package:flutter_e_commerce_app_2025/generated/assets.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
    required this.imageUrl,
    required this.onPressed,
  });

  final String? imageUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        CustomImage(
          imageSize: size.width * .35,
          imageProvider: imageUrl != null && imageUrl!.length > 100
              ? Image.memory(base64Decode(imageUrl!))
              : imageUrl != null && imageUrl!.contains('http')
              ? CachedNetworkImage(imageUrl: imageUrl!)
              : Image.asset(Assets.profileDefulatProfileImage),
        ),
        Positioned(
          bottom: size.width * 0.025,
          right: size.width * 0.01,
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade200
                    : Colors.grey.shade800,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: size.width * 0.055,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade900
                    : Colors.grey.shade50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
