import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/utilities/custom_text.dart';
import '../../../../../core/utilities/custom_text_form_field.dart';
import '../../../../../core/utilities/extensions_of_s_localization.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/model/location_model.dart';
import '../../view_model/checkout_cubit/checkout_cubit.dart';
import '../../view_model/get_cart_cubit/get_cart_cubit.dart'; // <-- اضفتها
import '../../view_model/get_cart_cubit/get_cart_state.dart';
import '../../view_model/order_cubit/order_cubit.dart';
import '../../view_model/order_cubit/order_state.dart';

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
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late LocationModel locationModel;
  TextEditingController textEditingControllerStreet1 = TextEditingController(),
      textEditingControllerStreet2 = TextEditingController(),
      textEditingControllerCity = TextEditingController(),
      textEditingControllerState = TextEditingController(),
      textEditingControllerCountry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = context.read<CheckoutCubit>();
    final size = MediaQuery.sizeOf(context);
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
        }
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            CustomText(
                              text: S.of(context).cart_billing_address,
                              fontSize: 14,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        buildFieldsSection(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * .3,
                        child: CustomButton(
                          onPressed: widget.onBack,
                          text: S.of(context).cart_back,
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
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: size.width * .3,
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

                              checkoutCubit.fillLocation(
                                locationModel: locationModel,
                              );

                              final cartState = context
                                  .read<GetCartCubit>()
                                  .state;
                              if (cartState is GetProductCartAndTotalSuccess) {
                                checkoutCubit.setCartData(
                                  totalPrice: cartState.totalPrice,
                                  cartList: cartState.carts,
                                );
                              }

                              if (checkoutCubit.orderModel != null) {
                                widget.onNext();
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
              ],
            ),
          ),
        );
      },
    );
  }

  Column buildFieldsSection(BuildContext context) {
    return Column(
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
    );
  }
}
