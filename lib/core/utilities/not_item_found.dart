import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_text.dart';

class NoItemFound extends StatelessWidget {
  const NoItemFound({
    super.key,
    required this.itemTitle,
    required this.itemImage,
  });

  final String itemTitle, itemImage;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(itemImage, height: screenSize.height * .25),
        const SizedBox(height: 16),
        CustomText(
          text: itemTitle,
          fontSize: 20,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
          color: Colors.black,
        ),
      ],
    );
  }
}

class NoItemFoundByIcon extends StatelessWidget {
  const NoItemFoundByIcon({
    super.key,
    required this.itemTitle,
    required this.iconData,
  });

  final String itemTitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: screenSize.height * .25),
        const SizedBox(height: 16),
        CustomText(
          text: itemTitle,
          fontSize: 20,
          alignment: Alignment.center,
          color: Colors.black,
        ),
      ],
    );
  }
}
