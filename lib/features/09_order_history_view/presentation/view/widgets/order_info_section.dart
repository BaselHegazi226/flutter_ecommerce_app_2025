import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/features/09_order_history_view/presentation/view_model/order_info_cubit/order_info_cubit.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../07_cart_view/data/model/location_model.dart';

class OrderInfoSection extends StatefulWidget {
  const OrderInfoSection({
    super.key,
    required this.locationModel,
    required this.phoneNumber,
  });

  final LocationModel locationModel;
  final String phoneNumber;

  @override
  State<OrderInfoSection> createState() => _OrderInfoSectionState();
}

class _OrderInfoSectionState extends State<OrderInfoSection> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController street1Controller;
  late final TextEditingController street2Controller;
  late final TextEditingController cityController;
  late final TextEditingController countryController;
  late final TextEditingController stateController;
  late final TextEditingController phoneNumberController;
  AutovalidateMode autoValidateModel = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();

    street1Controller = TextEditingController(
      text: widget.locationModel.street1,
    );

    street2Controller = TextEditingController(
      text: widget.locationModel.street2,
    );

    cityController = TextEditingController(text: widget.locationModel.city);

    countryController = TextEditingController(
      text: widget.locationModel.country,
    );

    stateController = TextEditingController(text: widget.locationModel.state);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    street1Controller.dispose();
    street2Controller.dispose();
    cityController.dispose();
    countryController.dispose();
    stateController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void _saveLocation() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updateLocation = LocationModel(
        street1: street1Controller.text,
        street2: street2Controller.text,
        city: cityController.text,
        country: countryController.text,
        state: stateController.text,
      );
      final updatedOrderInfo = OrderInfoModel(
        locationModel: updateLocation,
        phoneNumber: phoneNumberController.text,
      );
      context.read<OrderInfoCubit>().saveOrderHistoryInfo(
        orderInfoModel: updatedOrderInfo,
      );

      /// هنا تقدر تبعته للكاش أو Cubit
      /// context.read<OrderInfoCubit>().updateLocation(updatedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  CustomTextFormField(
                    iconData: Icons.phone_outlined,
                    text: S.of(context).phoneNumber,
                    hintText: S.of(context).phoneNumber,
                    textEditingController: phoneNumberController,
                    validator: (value) => value!.isEmpty
                        ? S.of(context).formPhoneNumberRequired
                        : null,
                    onSaved: (_) {},
                  ),
                  _locationSection(context),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: S.of(context).profileEditSave,
            textColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade600
                : Colors.grey.shade200,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade200
                : kPrimaryColor,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _saveLocation();
              } else {
                autoValidateModel = AutovalidateMode.onUserInteraction;
              }
            },
          ),
        ],
      ),
    );
  }

  Column _locationSection(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        CustomTextFormField(
          iconData: Icons.signpost_outlined,
          text: S.of(context).formStreet1,
          hintText: S.of(context).formStreet1,
          textEditingController: street1Controller,
          validator: (value) =>
              value!.isEmpty ? S.of(context).formStreet1Required : null,
          onSaved: (_) {},
        ),

        CustomTextFormField(
          iconData: Icons.signpost_outlined,
          text: S.of(context).formStreet2,
          hintText: S.of(context).formStreet2,
          textEditingController: street2Controller,
          validator: (value) =>
              value!.isEmpty ? S.of(context).formStreet2Required : null,
          onSaved: (_) {},
        ),

        CustomTextFormField(
          iconData: Icons.location_city_outlined,
          text: S.of(context).formCity,
          hintText: S.of(context).formCity,
          textEditingController: cityController,
          validator: (value) =>
              value!.isEmpty ? S.of(context).formCityRequired : null,
          onSaved: (_) {},
        ),

        CustomTextFormField(
          iconData: Icons.public,
          text: S.of(context).formState,
          hintText: S.of(context).formState,
          textEditingController: stateController,
          validator: (value) =>
              value!.isEmpty ? S.of(context).formStateRequired : null,
          onSaved: (_) {},
        ),

        CustomTextFormField(
          iconData: Icons.flag_outlined,
          text: S.of(context).formCountry,
          hintText: S.of(context).formCountry,
          textEditingController: countryController,
          validator: (value) =>
              value!.isEmpty ? S.of(context).formCountryRequired : null,
          onSaved: (_) {},
        ),
      ],
    );
  }
}
