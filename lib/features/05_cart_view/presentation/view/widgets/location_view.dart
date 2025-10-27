import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text_form_field.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';

import '../../../data/model/location_model.dart';
import '../../view_model/checkout_cubit/checkout_cubit.dart';

class LocationView extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const LocationView({super.key, required this.onBack, required this.onNext});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  String street1 = '', street2 = '', city = '', state = '', country = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController textEditingControllerStreet1 = TextEditingController(),
      textEditingControllerStreet2 = TextEditingController(),
      textEditingControllerCity = TextEditingController(),
      textEditingControllerState = TextEditingController(),
      textEditingControllerCountry = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late LocationModel locationModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 24),
          const Row(
            spacing: 8,
            children: [
              Icon(Icons.check_circle, color: kPrimaryColor),
              CustomText(
                text: 'Billing address is the same as delivery address',
                fontSize: 14,
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            spacing: 16,
            children: [
              CustomTextFormField(
                text: 'Street 1',
                hintText: 'Enter street 1',
                onSaved: (value) {
                  street1 = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'street 1 is required';
                  }
                  return null;
                },
                textEditingController: textEditingControllerStreet1,
              ),
              CustomTextFormField(
                text: 'Street 2',
                hintText: 'Enter street 2',
                onSaved: (value) {
                  street2 = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'street 2 is required';
                  }
                  return null;
                },
                textEditingController: textEditingControllerStreet2,
              ),
              CustomTextFormField(
                text: 'City',
                hintText: 'Enter city',
                onSaved: (value) {
                  city = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'city is required';
                  }
                  return null;
                },
                textEditingController: textEditingControllerCity,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      text: 'State',
                      hintText: 'Enter State',
                      onSaved: (value) {
                        state = value!.trim();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'state is required';
                        }
                        return null;
                      },
                      textEditingController: textEditingControllerState,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: CustomTextFormField(
                      text: 'Country',
                      hintText: 'Enter country',
                      onSaved: (value) {
                        country = value!.trim();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'country is required';
                        }
                        return null;
                      },
                      textEditingController: textEditingControllerCountry,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: CustomButton(
                    backgroundColor: Colors.white,
                    textColor: kPrimaryColor,
                    borderColor: kPrimaryColor,
                    onPressed: widget.onBack,
                    text: 'Back',
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        locationModel = LocationModel(
                          street1: street1,
                          street2: street2,
                          city: city,
                          state: state,
                          country: country,
                        );
                        cubit.fillLocation(locationModel: locationModel);
                        if (cubit.getLocationModel != null) {
                          widget.onNext();
                          context
                              .read<GetCartCubit>()
                              .getCartProductsAndTotal();
                        }
                      } else {
                        autovalidateMode = AutovalidateMode.onUserInteraction;
                      }
                    },
                    text: 'Next',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
