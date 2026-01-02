import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text_form_field.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/get_cart_cubit/get_cart_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:flutter_e_commerce_app_2025/features/05_cart_view/presentation/view_model/order_cubit/order_state.dart';

import '../../../../../generated/l10n.dart';
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
  String street1 = '', street2 = '', city = '', stateEnum = '', country = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController textEditingControllerStreet1 = TextEditingController(),
      textEditingControllerStreet2 = TextEditingController(),
      textEditingControllerCity = TextEditingController(),
      textEditingControllerState = TextEditingController(),
      textEditingControllerCountry = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late LocationModel locationModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is GetUserLocationSuccess &&
            textEditingControllerStreet1.text.isEmpty &&
            textEditingControllerStreet2.text.isEmpty &&
            textEditingControllerCity.text.isEmpty &&
            textEditingControllerState.text.isEmpty &&
            textEditingControllerCountry.text.isEmpty) {
          textEditingControllerStreet1.text = state.locationModel.street1;
          textEditingControllerStreet2.text = state.locationModel.street2;
          textEditingControllerCity.text = state.locationModel.city;
          textEditingControllerState.text = state.locationModel.state;
          textEditingControllerCountry.text = state.locationModel.country;
          debugPrint('user location = ${state.locationModel.toJson()}');
          debugPrint(
            '$textEditingControllerStreet1 $textEditingControllerStreet2 $textEditingControllerCountry $textEditingControllerCity $textEditingControllerState',
          );
        }
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  spacing: 8,
                  children: [
                    const Icon(Icons.check_circle, color: kPrimaryColor),
                    CustomText(
                      text: S.of(context).cart_billing_address,
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
                      text: S.of(context).formStreet1,
                      hintText: S.of(context).formEnterStreet1,
                      onSaved: (value) {
                        street1 = value!.trim();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).formStreet1Required;
                        }
                        return null;
                      },
                      textEditingController: textEditingControllerStreet1,
                    ),
                    CustomTextFormField(
                      text: S.of(context).formStreet2,
                      hintText: S.of(context).formEnterStreet2,
                      onSaved: (value) {
                        street2 = value!.trim();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).formStreet2Required;
                        }
                        return null;
                      },
                      textEditingController: textEditingControllerStreet2,
                    ),
                    CustomTextFormField(
                      text: S.of(context).formCity,
                      hintText: S.of(context).formEnterCity,
                      onSaved: (value) {
                        city = value!.trim();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).formCityRequired;
                        }
                        return null;
                      },
                      textEditingController: textEditingControllerCity,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            text: S.of(context).formState,
                            hintText: S.of(context).formEnterState,
                            onSaved: (value) {
                              stateEnum = value!.trim();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).formStateRequired;
                              }
                              return null;
                            },
                            textEditingController: textEditingControllerState,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: CustomTextFormField(
                            text: S.of(context).formCountry,
                            hintText: S.of(context).formEnterCountry,
                            onSaved: (value) {
                              country = value!.trim();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).formCountryRequired;
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
                const SizedBox(height: 16),
                const Expanded(child: SizedBox()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: CustomButton(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade700
                              : kScaffoldColor,
                          borderColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryColor,
                          textColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade200
                              : kPrimaryColor,
                          onPressed: widget.onBack,
                          text: S.of(context).cart_back,
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
                                state: stateEnum,
                                country: country,
                              );
                              cubit.fillLocation(locationModel: locationModel);
                              if (cubit.getLocationModel != null) {
                                widget.onNext();
                                context
                                    .read<GetCartCubit>()
                                    .getCartProductsAndTotal();
                                context.read<OrderCubit>().saveUserLocation(
                                  locationModel: locationModel,
                                );
                              }
                            } else {
                              autoValidateMode =
                                  AutovalidateMode.onUserInteraction;
                            }
                          },
                          text: S.of(context).cart_next,
                          textColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade600
                              : Colors.grey.shade200,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade200
                              : kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
