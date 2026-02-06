import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/navigate_button.dart';

import '../../../../../core/helper/const.dart';
import '../../../../../core/helper/fields_contranits.dart';
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

class OrderInfoView extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OrderInfoView({super.key, required this.onBack, required this.onNext});

  @override
  State<OrderInfoView> createState() => _OrderInfoViewState();
}

class _OrderInfoViewState extends State<OrderInfoView> {
  String street1 = '', street2 = '', city = '', stateEnum = '', country = '';
  String phoneNumber = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late OrderInfoModel orderInfoModel;
  TextEditingController textEditingControllerStreet1 = TextEditingController(),
      textEditingControllerStreet2 = TextEditingController(),
      textEditingControllerCity = TextEditingController(),
      textEditingControllerState = TextEditingController(),
      textEditingControllerCountry = TextEditingController(),
      phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = context.read<CheckoutCubit>();
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is GetOrderInfoSuccess &&
            textEditingControllerStreet1.text.isEmpty &&
            textEditingControllerStreet2.text.isEmpty &&
            textEditingControllerCity.text.isEmpty &&
            textEditingControllerState.text.isEmpty &&
            textEditingControllerCountry.text.isEmpty) {
          textEditingControllerStreet1.text =
              state.orderInfoModel.locationModel!.street1;
          textEditingControllerStreet2.text =
              state.orderInfoModel.locationModel!.street2;
          textEditingControllerCity.text =
              state.orderInfoModel.locationModel!.city;
          textEditingControllerState.text =
              state.orderInfoModel.locationModel!.state;
          textEditingControllerCountry.text =
              state.orderInfoModel.locationModel!.country;
          phoneNumberController.text = state.orderInfoModel.phoneNumber!;
        } else if (state is GetOrderInfoFailure) {
          debugPrint('${state.errorMessage} ======================>');
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
                        const SizedBox(height: 16),
                        buildPhoneNumberSection(context),
                        const SizedBox(height: 24),
                        buildIconTitleSection(
                          context,
                          Icons.location_on_outlined,
                          S.of(context).cart_billing_address,
                        ),
                        const SizedBox(height: 16),
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
                        child: NavigateButton(
                          isBack: true,
                          onPressed: widget.onBack,
                          text: S.of(context).cart_back,
                          iconSize: 14,
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
                        child: NavigateButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              checkoutCubit.fillOrderInfo(
                                state: stateEnum,
                                street1: street1,
                                street2: street2,
                                city: city,
                                country: country,
                                phoneNumber: phoneNumber,
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

  Row buildIconTitleSection(BuildContext context, IconData icon, String text) {
    return Row(
      spacing: 8,
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        CustomText(text: text, fontSize: 14, alignment: Alignment.centerLeft),
      ],
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

  Column buildPhoneNumberSection(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          text: S.of(context).phoneNumber,
          hintText: '+201287790732',
          onSaved: (value) {
            phoneNumber = value!.trim();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).formPhoneNumberRequired;
            } else if (!FieldsContranits.egyptPhoneReg.hasMatch(value)) {
              return S.of(context).formPhoneNumberNotMatch;
            }
            return null;
          },
          textEditingController: phoneNumberController,
        ),
      ],
    );
  }
}
