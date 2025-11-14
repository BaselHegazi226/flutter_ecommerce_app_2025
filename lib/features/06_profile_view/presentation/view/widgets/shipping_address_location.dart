import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/data/model/location_model.dart';

import '../../../../../generated/l10n.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key, required this.locationModel});
  final LocationModel locationModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        LocationItem(
          location: S.of(context).Street1,
          value: locationModel.street1,
        ),
        LocationItem(
          location: S.of(context).Street2,
          value: locationModel.street2,
        ),
        LocationItem(location: S.of(context).City, value: locationModel.city),
        LocationItem(
          location: S.of(context).Country,
          value: locationModel.country,
        ),
        LocationItem(location: S.of(context).State, value: locationModel.state),
      ],
    );
  }
}

class LocationItem extends StatelessWidget {
  const LocationItem({super.key, required this.location, required this.value});
  final String location;
  final String? value;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.all(16),
      width: screenSize.width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade200
              : Colors.black,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        // boxShadow: [
        // BoxShadow(
        //   color: Colors.grey.shade100,
        //   blurRadius: 4,
        //   spreadRadius: 2,
        //   offset: const Offset(0, 2),
        // ),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenSize.width * .3,
            child: Row(
              children: [
                // Icon(
                //   Icons.location_on_outlined,
                //   size: 24,
                //   color: Theme.of(context).brightness == Brightness.dark
                //       ? Colors.grey.shade200
                //       : Colors.black,
                // ),
                // const SizedBox(width: 4),
                CustomText(
                  text: '$location : ',
                  fontSize: 16,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomText(
              text: value ?? 'Address not found',
              fontSize: 14,
              alignment: Alignment.centerRight,
            ),
          ),
        ],
      ),
    );
  }
}
