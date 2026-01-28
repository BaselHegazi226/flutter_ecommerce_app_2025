import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/routes.dart';
import '../../../../core/utilities/custom_text.dart';
import '../../../../generated/l10n.dart';
import '../helper/const.dart';

class CustomSliverGridListView extends StatelessWidget {
  final double childAspectRatio;
  final List<dynamic> items;
  final int itemsInLine;
  final double crossAxisSpacing, mainAxisSpacing;

  const CustomSliverGridListView({
    super.key,
    this.childAspectRatio = .55,
    required this.items,
    this.itemsInLine = 2,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemsInLine,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final product = items[index];
        return CustomSliverGridItem(
          screenSize: size,
          image: product.images[0],
          title: product.title,
          description: product.description,
          price: product.price,
          onTap: () {
            GoRouter.of(
              context,
            ).push(Routes.productDetailsView, extra: product.id);
          },
        );
      }, childCount: items.length),
    );
  }
}

class CustomSliverGridItem extends StatelessWidget {
  const CustomSliverGridItem({
    super.key,
    required this.screenSize,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.onTap,
  });

  final Size screenSize;
  final String image, title, description;
  final double price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          const SizedBox(height: 8),
          _buildDetailsSection(context),
        ],
      ),
    );
  }

  Expanded _buildImageSection() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.shade500.withAlpha(32),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.contain,
          // مهم عشان تملى المساحة كويس
          errorWidget: (error, url, child) {
            return const Icon(Icons.image);
          },
        ),
      ),
    );
  }

  Column _buildDetailsSection(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title.replaceAll("\"n", " "),
          fontSize: 16,
          maxLines: 1,
          fontWeight: FontWeight.bold,
        ),
        CustomText(
          text: description.replaceAll("\n", " "),
          fontSize: 12,
          maxLines: 1,
          color: const Color(0xff929292),
        ),
        CustomText(
          text: '${priceShowed(price)} ${S.of(context).EP}',
          fontSize: 16,
          color: kPrimaryColor,
        ),
      ],
    );
  }
}

class CustomGridListView extends StatelessWidget {
  const CustomGridListView({
    super.key,
    this.childAspectRatio = .55,
    required this.items,
    this.itemsInLine = 2,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
    this.shrinkWrap = false,
  });

  final double childAspectRatio;
  final List<dynamic> items;
  final int itemsInLine;
  final double crossAxisSpacing, mainAxisSpacing;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GridView.builder(
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: shrinkWrap,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemsInLine,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        final product = items[index];
        return CustomSliverGridItem(
          screenSize: size,
          image: product.images[0],
          title: product.title,
          description: product.description,
          price: product.price,
          onTap: () {
            GoRouter.of(
              context,
            ).push(Routes.productDetailsView, extra: product.id);
          },
        );
      },
    );
  }
}
