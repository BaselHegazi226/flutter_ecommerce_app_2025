import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavouriteItemCustomImage extends StatelessWidget {
  const FavouriteItemCustomImage({
    super.key,
    required this.imageUrl,
    required this.itemHeight,
    this.paddingValue = 4,
  });

  final String imageUrl;
  final double itemHeight;
  final double paddingValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      padding: EdgeInsets.all(paddingValue),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade400.withAlpha(32)
            : Colors.grey.shade700.withAlpha(32),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        errorWidget: (context, url, error) {
          return const Icon(Icons.image_not_supported_outlined);
        },
        imageUrl: imageUrl,
      ),
    );
  }
}
