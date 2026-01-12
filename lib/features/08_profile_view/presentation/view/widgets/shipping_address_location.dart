import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

import '../../../../../generated/l10n.dart';
import '../../../../07_cart_view/data/model/location_model.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key, required this.locationModel});

  final LocationModel locationModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        LocationItem(
          location: S.of(context).formStreet1,
          value: locationModel.street1,
        ),
        LocationItem(
          location: S.of(context).formStreet2,
          value: locationModel.street2,
        ),
        LocationItem(
          location: S.of(context).formCity,
          value: locationModel.city,
        ),
        LocationItem(
          location: S.of(context).formCountry,
          value: locationModel.country,
        ),
        LocationItem(
          location: S.of(context).formState,
          value: locationModel.state,
        ),
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
        //   spreadRadius: 0,
        //   offset: const Offset(0, 2),
        // ),
        //],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: '$location : ',
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
          const SizedBox(width: 4),
          CustomText(
            text: value ?? 'Address not found',
            fontSize: 14,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade400
                : Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}
