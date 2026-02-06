// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `EP`
  String get EP {
    return Intl.message('EP', name: 'EP', desc: '', args: []);
  }

  /// `Home`
  String get nav_home {
    return Intl.message('Home', name: 'nav_home', desc: '', args: []);
  }

  /// `Search`
  String get nav_search {
    return Intl.message('Search', name: 'nav_search', desc: '', args: []);
  }

  /// `Cart`
  String get nav_cart {
    return Intl.message('Cart', name: 'nav_cart', desc: '', args: []);
  }

  /// `Profile`
  String get nav_profile {
    return Intl.message('Profile', name: 'nav_profile', desc: '', args: []);
  }

  /// `Welcome, `
  String get home_welcome {
    return Intl.message('Welcome, ', name: 'home_welcome', desc: '', args: []);
  }

  /// `Categories`
  String get home_categories {
    return Intl.message(
      'Categories',
      name: 'home_categories',
      desc: '',
      args: [],
    );
  }

  /// `App Products`
  String get home_app_products {
    return Intl.message(
      'App Products',
      name: 'home_app_products',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get home_showAll {
    return Intl.message('Show All', name: 'home_showAll', desc: '', args: []);
  }

  /// `All Products`
  String get home_allProducts {
    return Intl.message(
      'All Products',
      name: 'home_allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get home_category {
    return Intl.message('Category', name: 'home_category', desc: '', args: []);
  }

  /// `Rating`
  String get home_rating {
    return Intl.message('Rating', name: 'home_rating', desc: '', args: []);
  }

  /// `Details`
  String get home_details {
    return Intl.message('Details', name: 'home_details', desc: '', args: []);
  }

  /// `Price`
  String get home_price {
    return Intl.message('Price', name: 'home_price', desc: '', args: []);
  }

  /// `Add To Cart`
  String get home_addToCart {
    return Intl.message(
      'Add To Cart',
      name: 'home_addToCart',
      desc: '',
      args: [],
    );
  }

  /// `No Products available Now `
  String get home_no_products_now {
    return Intl.message(
      'No Products available Now ',
      name: 'home_no_products_now',
      desc: '',
      args: [],
    );
  }

  /// `No Categories available now!`
  String get home_not_categories_available_now {
    return Intl.message(
      'No Categories available now!',
      name: 'home_not_categories_available_now',
      desc: '',
      args: [],
    );
  }

  /// `No User Data Found`
  String get home_not_user_found {
    return Intl.message(
      'No User Data Found',
      name: 'home_not_user_found',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get cart_checkout {
    return Intl.message('Checkout', name: 'cart_checkout', desc: '', args: []);
  }

  /// `Billing Address`
  String get cart_billing_address {
    return Intl.message(
      'Billing Address',
      name: 'cart_billing_address',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get cart_phone_number {
    return Intl.message(
      'Phone Number',
      name: 'cart_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get cart_total {
    return Intl.message('Total', name: 'cart_total', desc: '', args: []);
  }

  /// `Delivery`
  String get cart_delivery {
    return Intl.message('Delivery', name: 'cart_delivery', desc: '', args: []);
  }

  /// `Order info`
  String get cart_order_info {
    return Intl.message(
      'Order info',
      name: 'cart_order_info',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get cart_location {
    return Intl.message('Location', name: 'cart_location', desc: '', args: []);
  }

  /// `Summarize`
  String get cart_summarize {
    return Intl.message(
      'Summarize',
      name: 'cart_summarize',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get cart_finish {
    return Intl.message('Finish', name: 'cart_finish', desc: '', args: []);
  }

  /// `Change order`
  String get cart_change_order {
    return Intl.message(
      'Change order',
      name: 'cart_change_order',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get cart_next {
    return Intl.message('Next', name: 'cart_next', desc: '', args: []);
  }

  /// `Back`
  String get cart_back {
    return Intl.message('Back', name: 'cart_back', desc: '', args: []);
  }

  /// `Payment`
  String get cart_payment {
    return Intl.message('Payment', name: 'cart_payment', desc: '', args: []);
  }

  /// `Next Day Delivery`
  String get cart_nextDayDelivery {
    return Intl.message(
      'Next Day Delivery',
      name: 'cart_nextDayDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Nominated Delivery`
  String get cart_nominatedDelivery {
    return Intl.message(
      'Nominated Delivery',
      name: 'cart_nominatedDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Standard Delivery`
  String get cart_standardDelivery {
    return Intl.message(
      'Standard Delivery',
      name: 'cart_standardDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Place your order before 6pm and your items will be delivered the next day`
  String get cart_placeYourOrder {
    return Intl.message(
      'Place your order before 6pm and your items will be delivered the next day',
      name: 'cart_placeYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Your order will reach before 6pm and your items will be delivered the next day`
  String get cart_placeYourOrder_result {
    return Intl.message(
      'Your order will reach before 6pm and your items will be delivered the next day',
      name: 'cart_placeYourOrder_result',
      desc: '',
      args: [],
    );
  }

  /// `Pick a particular date from the calendar and order will be delivered on selected date`
  String get cart_pickAParticular {
    return Intl.message(
      'Pick a particular date from the calendar and order will be delivered on selected date',
      name: 'cart_pickAParticular',
      desc: '',
      args: [],
    );
  }

  /// `Your order will reach in`
  String get cart_pickAParticular_result {
    return Intl.message(
      'Your order will reach in',
      name: 'cart_pickAParticular_result',
      desc: '',
      args: [],
    );
  }

  /// `Order will be delivered between 3 - 5 business days`
  String get cart_orderWillBe {
    return Intl.message(
      'Order will be delivered between 3 - 5 business days',
      name: 'cart_orderWillBe',
      desc: '',
      args: [],
    );
  }

  /// `Order will be delivered between 3 - 5 business days`
  String get cart_orderWillBe_result {
    return Intl.message(
      'Order will be delivered between 3 - 5 business days',
      name: 'cart_orderWillBe_result',
      desc: '',
      args: [],
    );
  }

  /// `Order Product List`
  String get cart_order_product_list {
    return Intl.message(
      'Order Product List',
      name: 'cart_order_product_list',
      desc: '',
      args: [],
    );
  }

  /// `Order Address`
  String get cart_order_address {
    return Intl.message(
      'Order Address',
      name: 'cart_order_address',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Time`
  String get cart_order_delivery_time {
    return Intl.message(
      'Delivery Time',
      name: 'cart_order_delivery_time',
      desc: '',
      args: [],
    );
  }

  /// `Choose delivery date`
  String get calendar_title {
    return Intl.message(
      'Choose delivery date',
      name: 'calendar_title',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get calendar_cancel {
    return Intl.message('Cancel', name: 'calendar_cancel', desc: '', args: []);
  }

  /// `Confirm`
  String get calendar_confirm {
    return Intl.message(
      'Confirm',
      name: 'calendar_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Try To Fill Cart`
  String get cart_tryToFill {
    return Intl.message(
      'Try To Fill Cart',
      name: 'cart_tryToFill',
      desc: '',
      args: [],
    );
  }

  /// `This product is already added to the cart`
  String get cart_alreadyInCart {
    return Intl.message(
      'This product is already added to the cart',
      name: 'cart_alreadyInCart',
      desc: '',
      args: [],
    );
  }

  /// `Delete Product`
  String get cart_delete_product_title {
    return Intl.message(
      'Delete Product',
      name: 'cart_delete_product_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete product?`
  String get cart_delete_product_desc {
    return Intl.message(
      'Are you sure to delete product?',
      name: 'cart_delete_product_desc',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get cart_add {
    return Intl.message('Add', name: 'cart_add', desc: '', args: []);
  }

  /// `Ok`
  String get warning_button_title_ok {
    return Intl.message(
      'Ok',
      name: 'warning_button_title_ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get warning_button_title_Cancel {
    return Intl.message(
      'Cancel',
      name: 'warning_button_title_Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get order_pending {
    return Intl.message('Pending', name: 'order_pending', desc: '', args: []);
  }

  /// `Delivered`
  String get order_delivered {
    return Intl.message(
      'Delivered',
      name: 'order_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Transmit`
  String get order_transmit {
    return Intl.message('Transmit', name: 'order_transmit', desc: '', args: []);
  }

  /// `Order is Ready To Make`
  String get order_ready {
    return Intl.message(
      'Order is Ready To Make',
      name: 'order_ready',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get order_cancel {
    return Intl.message(
      'Cancel Order',
      name: 'order_cancel',
      desc: '',
      args: [],
    );
  }

  /// `No Location Found, try making an order!`
  String get order_noLocation {
    return Intl.message(
      'No Location Found, try making an order!',
      name: 'order_noLocation',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get order_history {
    return Intl.message('Orders', name: 'order_history', desc: '', args: []);
  }

  /// `Not found order history now!`
  String get order_history_no_found_orders {
    return Intl.message(
      'Not found order history now!',
      name: 'order_history_no_found_orders',
      desc: '',
      args: [],
    );
  }

  /// `Delivery state`
  String get order_delivery_state {
    return Intl.message(
      'Delivery state',
      name: 'order_delivery_state',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get order_delete {
    return Intl.message('Delete', name: 'order_delete', desc: '', args: []);
  }

  /// `All`
  String get order_all {
    return Intl.message('All', name: 'order_all', desc: '', args: []);
  }

  /// `Order id`
  String get order_order_id {
    return Intl.message('Order id', name: 'order_order_id', desc: '', args: []);
  }

  /// ``
  String get from {
    return Intl.message('', name: 'from', desc: '', args: []);
  }

  /// `items`
  String get items {
    return Intl.message('items', name: 'items', desc: '', args: []);
  }

  /// `Total Price`
  String get order_total_price {
    return Intl.message(
      'Total Price',
      name: 'order_total_price',
      desc: '',
      args: [],
    );
  }

  /// `Is Already added`
  String get order_added_done {
    return Intl.message(
      'Is Already added',
      name: 'order_added_done',
      desc: '',
      args: [],
    );
  }

  /// `Delete Order History`
  String get delete_order_history_title {
    return Intl.message(
      'Delete Order History',
      name: 'delete_order_history_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete all order history? \n`
  String get delete_order_description {
    return Intl.message(
      'Are you sure to delete all order history? \n',
      name: 'delete_order_description',
      desc: '',
      args: [],
    );
  }

  /// `Street 1`
  String get form_street1 {
    return Intl.message('Street 1', name: 'form_street1', desc: '', args: []);
  }

  /// `Street 2`
  String get form_street2 {
    return Intl.message('Street 2', name: 'form_street2', desc: '', args: []);
  }

  /// `City`
  String get form_city {
    return Intl.message('City', name: 'form_city', desc: '', args: []);
  }

  /// `State`
  String get form_state {
    return Intl.message('State', name: 'form_state', desc: '', args: []);
  }

  /// `Country`
  String get form_country {
    return Intl.message('Country', name: 'form_country', desc: '', args: []);
  }

  /// `Country is required`
  String get form_countryRequired {
    return Intl.message(
      'Country is required',
      name: 'form_countryRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter country`
  String get form_enterCountry {
    return Intl.message(
      'Enter country',
      name: 'form_enterCountry',
      desc: '',
      args: [],
    );
  }

  /// `State is required`
  String get form_stateRequired {
    return Intl.message(
      'State is required',
      name: 'form_stateRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter state`
  String get form_enterState {
    return Intl.message(
      'Enter state',
      name: 'form_enterState',
      desc: '',
      args: [],
    );
  }

  /// `City is required`
  String get form_cityRequired {
    return Intl.message(
      'City is required',
      name: 'form_cityRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter city`
  String get form_enterCity {
    return Intl.message(
      'Enter city',
      name: 'form_enterCity',
      desc: '',
      args: [],
    );
  }

  /// `Street 1 is required`
  String get form_street1Required {
    return Intl.message(
      'Street 1 is required',
      name: 'form_street1Required',
      desc: '',
      args: [],
    );
  }

  /// `Enter street 1`
  String get form_enterStreet1 {
    return Intl.message(
      'Enter street 1',
      name: 'form_enterStreet1',
      desc: '',
      args: [],
    );
  }

  /// `Street 2 is required`
  String get form_street2Required {
    return Intl.message(
      'Street 2 is required',
      name: 'form_street2Required',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get form_phoneNumberRequired {
    return Intl.message(
      'Phone number is required',
      name: 'form_phoneNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter street 2`
  String get form_enterStreet2 {
    return Intl.message(
      'Enter street 2',
      name: 'form_enterStreet2',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get form_enterPhoneNumber {
    return Intl.message(
      'Enter phone number',
      name: 'form_enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Not match For Masr Number`
  String get form_phone_number_not_match {
    return Intl.message(
      'Not match For Masr Number',
      name: 'form_phone_number_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Select Favourite Language`
  String get language_selected_text {
    return Intl.message(
      'Select Favourite Language',
      name: 'language_selected_text',
      desc: '',
      args: [],
    );
  }

  /// `Discover products with smart and wide search`
  String get onboarding_title_img1 {
    return Intl.message(
      'Discover products with smart and wide search',
      name: 'onboarding_title_img1',
      desc: '',
      args: [],
    );
  }

  /// `Easily find the products you are looking for\nQuick access to what matters most`
  String get onboarding_desc_img1 {
    return Intl.message(
      'Easily find the products you are looking for\nQuick access to what matters most',
      name: 'onboarding_desc_img1',
      desc: '',
      args: [],
    );
  }

  /// `Explore a wide and several product collection`
  String get onboarding_title_img2 {
    return Intl.message(
      'Explore a wide and several product collection',
      name: 'onboarding_title_img2',
      desc: '',
      args: [],
    );
  }

  /// `Browse a diverse range of products\nCarefully selected to match every taste`
  String get onboarding_desc_img2 {
    return Intl.message(
      'Browse a diverse range of products\nCarefully selected to match every taste',
      name: 'onboarding_desc_img2',
      desc: '',
      args: [],
    );
  }

  /// `Secure and simple checkout experience`
  String get onboarding_title_img3 {
    return Intl.message(
      'Secure and simple checkout experience',
      name: 'onboarding_title_img3',
      desc: '',
      args: [],
    );
  }

  /// `Complete your payments safely and smoothly Multiple trusted payment options available`
  String get onboarding_desc_img3 {
    return Intl.message(
      'Complete your payments safely and smoothly Multiple trusted payment options available',
      name: 'onboarding_desc_img3',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get onboarding_next {
    return Intl.message('Next', name: 'onboarding_next', desc: '', args: []);
  }

  /// `Skip`
  String get onboarding_skip {
    return Intl.message('Skip', name: 'onboarding_skip', desc: '', args: []);
  }

  /// `Email`
  String get auth_email {
    return Intl.message('Email', name: 'auth_email', desc: '', args: []);
  }

  /// `Password`
  String get auth_password {
    return Intl.message('Password', name: 'auth_password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get auth_confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'auth_confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get auth_name {
    return Intl.message('Name', name: 'auth_name', desc: '', args: []);
  }

  /// `Forgot password?`
  String get auth_forgetPassword {
    return Intl.message(
      'Forgot password?',
      name: 'auth_forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get auth_or {
    return Intl.message('Or', name: 'auth_or', desc: '', args: []);
  }

  /// `Sign In`
  String get auth_signIn {
    return Intl.message('Sign In', name: 'auth_signIn', desc: '', args: []);
  }

  /// `Sign in to continue`
  String get auth_signInToContinue {
    return Intl.message(
      'Sign in to continue',
      name: 'auth_signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get auth_signInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'auth_signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get auth_signInWithFacebook {
    return Intl.message(
      'Sign in with Facebook',
      name: 'auth_signInWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get auth_signUp {
    return Intl.message('Sign Up', name: 'auth_signUp', desc: '', args: []);
  }

  /// `Create an account to continue`
  String get auth_signUpToContinue {
    return Intl.message(
      'Create an account to continue',
      name: 'auth_signUpToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get auth_nameRequired {
    return Intl.message(
      'Name is required',
      name: 'auth_nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get auth_emailRequired {
    return Intl.message(
      'Email is required',
      name: 'auth_emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get auth_passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'auth_passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid name`
  String get auth_enterValidName {
    return Intl.message(
      'Enter a valid name',
      name: 'auth_enterValidName',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email (example@email.com)`
  String get auth_enterValidEmail {
    return Intl.message(
      'Enter a valid email (example@email.com)',
      name: 'auth_enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter a strong password`
  String get auth_enterStrongPassword {
    return Intl.message(
      'Enter a strong password',
      name: 'auth_enterStrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get auth_passwordNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'auth_passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get success_login_title {
    return Intl.message(
      'Welcome back!',
      name: 'success_login_title',
      desc: '',
      args: [],
    );
  }

  /// `You have logged in successfully. Enjoy your experience.`
  String get success_login_desc {
    return Intl.message(
      'You have logged in successfully. Enjoy your experience.',
      name: 'success_login_desc',
      desc: '',
      args: [],
    );
  }

  /// `Account Created`
  String get success_register_title {
    return Intl.message(
      'Account Created',
      name: 'success_register_title',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been created successfully. You can start now.`
  String get success_register_desc {
    return Intl.message(
      'Your account has been created successfully. You can start now.',
      name: 'success_register_desc',
      desc: '',
      args: [],
    );
  }

  /// `Success Added `
  String get success_addToCart_title {
    return Intl.message(
      'Success Added ',
      name: 'success_addToCart_title',
      desc: '',
      args: [],
    );
  }

  /// `The product has been added to your cart successfully.`
  String get success_addToCart_desc {
    return Intl.message(
      'The product has been added to your cart successfully.',
      name: 'success_addToCart_desc',
      desc: '',
      args: [],
    );
  }

  /// `Removed`
  String get success_removeFromCart_title {
    return Intl.message(
      'Removed',
      name: 'success_removeFromCart_title',
      desc: '',
      args: [],
    );
  }

  /// `The product has been removed from your cart.`
  String get success_removeFromCart_desc {
    return Intl.message(
      'The product has been removed from your cart.',
      name: 'success_removeFromCart_desc',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successful`
  String get success_payment_title {
    return Intl.message(
      'Payment Successful',
      name: 'success_payment_title',
      desc: '',
      args: [],
    );
  }

  /// `Your payment was completed successfully. Thank you!`
  String get success_payment_desc {
    return Intl.message(
      'Your payment was completed successfully. Thank you!',
      name: 'success_payment_desc',
      desc: '',
      args: [],
    );
  }

  /// `Profile Updated`
  String get success_updateProfile_title {
    return Intl.message(
      'Profile Updated',
      name: 'success_updateProfile_title',
      desc: '',
      args: [],
    );
  }

  /// `Your account information has been updated successfully.`
  String get success_updateProfile_desc {
    return Intl.message(
      'Your account information has been updated successfully.',
      name: 'success_updateProfile_desc',
      desc: '',
      args: [],
    );
  }

  /// `Order Info`
  String get success_update_order_info_title {
    return Intl.message(
      'Order Info',
      name: 'success_update_order_info_title',
      desc: '',
      args: [],
    );
  }

  /// `Your Order information has been updated successfully.`
  String get success_update_order_info_desc {
    return Intl.message(
      'Your Order information has been updated successfully.',
      name: 'success_update_order_info_desc',
      desc: '',
      args: [],
    );
  }

  /// `Selected Image Success`
  String get success_selected_Image_title {
    return Intl.message(
      'Selected Image Success',
      name: 'success_selected_Image_title',
      desc: '',
      args: [],
    );
  }

  /// `Your New Image has been selected successfully.`
  String get success_selected_Image_desc {
    return Intl.message(
      'Your New Image has been selected successfully.',
      name: 'success_selected_Image_desc',
      desc: '',
      args: [],
    );
  }

  /// `Removed from Favorites`
  String get success_removeFavorite_title {
    return Intl.message(
      'Removed from Favorites',
      name: 'success_removeFavorite_title',
      desc: '',
      args: [],
    );
  }

  /// `The product has been removed from your favorites.`
  String get success_removeFavorite_desc {
    return Intl.message(
      'The product has been removed from your favorites.',
      name: 'success_removeFavorite_desc',
      desc: '',
      args: [],
    );
  }

  /// `Favorites Cleared`
  String get success_clearFavorites_title {
    return Intl.message(
      'Favorites Cleared',
      name: 'success_clearFavorites_title',
      desc: '',
      args: [],
    );
  }

  /// `All favorite products have been removed successfully.`
  String get success_clearFavorites_desc {
    return Intl.message(
      'All favorite products have been removed successfully.',
      name: 'success_clearFavorites_desc',
      desc: '',
      args: [],
    );
  }

  /// `Order Removed`
  String get success_removeOrder_title {
    return Intl.message(
      'Order Removed',
      name: 'success_removeOrder_title',
      desc: '',
      args: [],
    );
  }

  /// `The order has been removed successfully.`
  String get success_removeOrder_desc {
    return Intl.message(
      'The order has been removed successfully.',
      name: 'success_removeOrder_desc',
      desc: '',
      args: [],
    );
  }

  /// `Order Cancelled`
  String get success_cancelOrder_title {
    return Intl.message(
      'Order Cancelled',
      name: 'success_cancelOrder_title',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been cancelled successfully.`
  String get success_cancelOrder_desc {
    return Intl.message(
      'Your order has been cancelled successfully.',
      name: 'success_cancelOrder_desc',
      desc: '',
      args: [],
    );
  }

  /// `Logged Out`
  String get success_logout_title {
    return Intl.message(
      'Logged Out',
      name: 'success_logout_title',
      desc: '',
      args: [],
    );
  }

  /// `You have logged out successfully. See you soon!`
  String get success_logout_desc {
    return Intl.message(
      'You have logged out successfully. See you soon!',
      name: 'success_logout_desc',
      desc: '',
      args: [],
    );
  }

  /// `Success Order`
  String get success_add_order_title {
    return Intl.message(
      'Success Order',
      name: 'success_add_order_title',
      desc: '',
      args: [],
    );
  }

  /// `Success Make Order make a lot!`
  String get success_add_order_desc {
    return Intl.message(
      'Success Make Order make a lot!',
      name: 'success_add_order_desc',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed`
  String get failure_login_title {
    return Intl.message(
      'Login Failed',
      name: 'failure_login_title',
      desc: '',
      args: [],
    );
  }

  /// `Registration Failed`
  String get failure_register_title {
    return Intl.message(
      'Registration Failed',
      name: 'failure_register_title',
      desc: '',
      args: [],
    );
  }

  /// `Order Failed`
  String get failure_addOrder_title {
    return Intl.message(
      'Order Failed',
      name: 'failure_addOrder_title',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed`
  String get failure_payment_title {
    return Intl.message(
      'Payment Failed',
      name: 'failure_payment_title',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart Failed`
  String get failure_addToCart_title {
    return Intl.message(
      'Add to Cart Failed',
      name: 'failure_addToCart_title',
      desc: '',
      args: [],
    );
  }

  /// `Update Failed`
  String get failure_updateProfile_title {
    return Intl.message(
      'Update Failed',
      name: 'failure_updateProfile_title',
      desc: '',
      args: [],
    );
  }

  /// `The data update failed due to some problems that may be related to the internet. Please try again!`
  String get failure_updateProfile_desc {
    return Intl.message(
      'The data update failed due to some problems that may be related to the internet. Please try again!',
      name: 'failure_updateProfile_desc',
      desc: '',
      args: [],
    );
  }

  /// `Selected Image Failed`
  String get failure_selected_Image_title {
    return Intl.message(
      'Selected Image Failed',
      name: 'failure_selected_Image_title',
      desc: '',
      args: [],
    );
  }

  /// `The image update failed due to some problems that may be related to the internet. Please try again!`
  String get failure_selected_Image_desc {
    return Intl.message(
      'The image update failed due to some problems that may be related to the internet. Please try again!',
      name: 'failure_selected_Image_desc',
      desc: '',
      args: [],
    );
  }

  /// `Update Failed`
  String get failure_update_order_info_title {
    return Intl.message(
      'Update Failed',
      name: 'failure_update_order_info_title',
      desc: '',
      args: [],
    );
  }

  /// `The data update failed due to some problems that may be related to the internet. Please try again!`
  String get failure_update_order_info_desc {
    return Intl.message(
      'The data update failed due to some problems that may be related to the internet. Please try again!',
      name: 'failure_update_order_info_desc',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout. Please try again.`
  String get error_connectionTimeout {
    return Intl.message(
      'Connection timeout. Please try again.',
      name: 'error_connectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout. Please try again.`
  String get error_sendTimeout {
    return Intl.message(
      'Send timeout. Please try again.',
      name: 'error_sendTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout. Please try again.`
  String get error_receiveTimeout {
    return Intl.message(
      'Receive timeout. Please try again.',
      name: 'error_receiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Connection error. Please check your internet.`
  String get error_connection {
    return Intl.message(
      'Connection error. Please check your internet.',
      name: 'error_connection',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error. Please try again.`
  String get error_unexpected {
    return Intl.message(
      'Unexpected error. Please try again.',
      name: 'error_unexpected',
      desc: '',
      args: [],
    );
  }

  /// `Unknown server error.`
  String get error_unknownServer {
    return Intl.message(
      'Unknown server error.',
      name: 'error_unknownServer',
      desc: '',
      args: [],
    );
  }

  /// `Invalid request.`
  String get error_badRequest {
    return Intl.message(
      'Invalid request.',
      name: 'error_badRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized. Please login again.`
  String get error_unauthorized {
    return Intl.message(
      'Unauthorized. Please login again.',
      name: 'error_unauthorized',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to perform this action.`
  String get error_forbidden {
    return Intl.message(
      'You don\'t have permission to perform this action.',
      name: 'error_forbidden',
      desc: '',
      args: [],
    );
  }

  /// `Requested resource not found.`
  String get error_notFound {
    return Intl.message(
      'Requested resource not found.',
      name: 'error_notFound',
      desc: '',
      args: [],
    );
  }

  /// `Conflict occurred.`
  String get error_conflict {
    return Intl.message(
      'Conflict occurred.',
      name: 'error_conflict',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error.`
  String get error_internalServer {
    return Intl.message(
      'Internal server error.',
      name: 'error_internalServer',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your connection.`
  String get error_networkRequestFailed {
    return Intl.message(
      'Network error. Please check your connection.',
      name: 'error_networkRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Too many requests. Try again later.`
  String get error_tooManyRequests {
    return Intl.message(
      'Too many requests. Try again later.',
      name: 'error_tooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `User not found.`
  String get error_userNotFound {
    return Intl.message(
      'User not found.',
      name: 'error_userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password.`
  String get error_wrongPassword {
    return Intl.message(
      'Wrong password.',
      name: 'error_wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `This email is already in use.`
  String get error_emailAlreadyInUse {
    return Intl.message(
      'This email is already in use.',
      name: 'error_emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address.`
  String get error_invalidEmail {
    return Intl.message(
      'Invalid email address.',
      name: 'error_invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Weak password.`
  String get error_weakPassword {
    return Intl.message(
      'Weak password.',
      name: 'error_weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `Operation not allowed.`
  String get error_operationNotAllowed {
    return Intl.message(
      'Operation not allowed.',
      name: 'error_operationNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `User account disabled.`
  String get error_userDisabled {
    return Intl.message(
      'User account disabled.',
      name: 'error_userDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Please login again.`
  String get error_requiresRecentLogin {
    return Intl.message(
      'Please login again.',
      name: 'error_requiresRecentLogin',
      desc: '',
      args: [],
    );
  }

  /// `Invalid verification code.`
  String get error_invalidVerificationCode {
    return Intl.message(
      'Invalid verification code.',
      name: 'error_invalidVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Invalid verification ID.`
  String get error_invalidVerificationId {
    return Intl.message(
      'Invalid verification ID.',
      name: 'error_invalidVerificationId',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error occurred.`
  String get error_unknownFirebase {
    return Intl.message(
      'Unknown error occurred.',
      name: 'error_unknownFirebase',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Edit Profile`
  String get profile_edit {
    return Intl.message(
      'Edit Profile',
      name: 'profile_edit',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get profile_update_title_button {
    return Intl.message(
      'Update Profile',
      name: 'profile_update_title_button',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get profile_shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'profile_shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `No Location Found try make order!`
  String get profile_no_shipping_address {
    return Intl.message(
      'No Location Found try make order!',
      name: 'profile_no_shipping_address',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get profile_favourite {
    return Intl.message(
      'Favourite',
      name: 'profile_favourite',
      desc: '',
      args: [],
    );
  }

  /// `No Favourite Item Found`
  String get profile_noFavourite {
    return Intl.message(
      'No Favourite Item Found',
      name: 'profile_noFavourite',
      desc: '',
      args: [],
    );
  }

  /// `Delete Item`
  String get profile_delete_favourite_Item_title {
    return Intl.message(
      'Delete Item',
      name: 'profile_delete_favourite_Item_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete item from favourite products`
  String get profile_delete_favourite_Item_desc {
    return Intl.message(
      'Are you sure to delete item from favourite products',
      name: 'profile_delete_favourite_Item_desc',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get profile_userName {
    return Intl.message(
      'User Name',
      name: 'profile_userName',
      desc: '',
      args: [],
    );
  }

  /// `User Email`
  String get profile_userEmail {
    return Intl.message(
      'User Email',
      name: 'profile_userEmail',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get profile_logout_title {
    return Intl.message(
      'Logout',
      name: 'profile_logout_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to logout?`
  String get profile_logout_desc {
    return Intl.message(
      'Are you sure to logout?',
      name: 'profile_logout_desc',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get profile_edit_save {
    return Intl.message('Save', name: 'profile_edit_save', desc: '', args: []);
  }

  /// `Settings`
  String get settings_title {
    return Intl.message('Settings', name: 'settings_title', desc: '', args: []);
  }

  /// `Notifications`
  String get settings_notifications {
    return Intl.message(
      'Notifications',
      name: 'settings_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get settings_mode {
    return Intl.message('Mode', name: 'settings_mode', desc: '', args: []);
  }

  /// `Change Theme`
  String get settings_change_theme {
    return Intl.message(
      'Change Theme',
      name: 'settings_change_theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_language {
    return Intl.message(
      'Language',
      name: 'settings_language',
      desc: '',
      args: [],
    );
  }

  /// `On / Off`
  String get settings_onOff {
    return Intl.message('On / Off', name: 'settings_onOff', desc: '', args: []);
  }

  /// `Dark`
  String get settings_dark {
    return Intl.message('Dark', name: 'settings_dark', desc: '', args: []);
  }

  /// `Light`
  String get settings_light {
    return Intl.message('Light', name: 'settings_light', desc: '', args: []);
  }

  /// `Logout`
  String get settings_logout {
    return Intl.message('Logout', name: 'settings_logout', desc: '', args: []);
  }

  /// `Beauty`
  String get category_beauty {
    return Intl.message('Beauty', name: 'category_beauty', desc: '', args: []);
  }

  /// `Fragrances`
  String get category_fragrances {
    return Intl.message(
      'Fragrances',
      name: 'category_fragrances',
      desc: '',
      args: [],
    );
  }

  /// `Furniture`
  String get category_furniture {
    return Intl.message(
      'Furniture',
      name: 'category_furniture',
      desc: '',
      args: [],
    );
  }

  /// `Groceries`
  String get category_groceries {
    return Intl.message(
      'Groceries',
      name: 'category_groceries',
      desc: '',
      args: [],
    );
  }

  /// `Home Decoration`
  String get category_home_decoration {
    return Intl.message(
      'Home Decoration',
      name: 'category_home_decoration',
      desc: '',
      args: [],
    );
  }

  /// `Kitchen Accessories`
  String get category_kitchen_accessories {
    return Intl.message(
      'Kitchen Accessories',
      name: 'category_kitchen_accessories',
      desc: '',
      args: [],
    );
  }

  /// `Laptops`
  String get category_laptops {
    return Intl.message(
      'Laptops',
      name: 'category_laptops',
      desc: '',
      args: [],
    );
  }

  /// `Men's Shirts`
  String get category_mens_shirts {
    return Intl.message(
      'Men\'s Shirts',
      name: 'category_mens_shirts',
      desc: '',
      args: [],
    );
  }

  /// `Men's Shoes`
  String get category_mens_shoes {
    return Intl.message(
      'Men\'s Shoes',
      name: 'category_mens_shoes',
      desc: '',
      args: [],
    );
  }

  /// `Men's Watches`
  String get category_mens_watches {
    return Intl.message(
      'Men\'s Watches',
      name: 'category_mens_watches',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Accessories`
  String get category_mobile_accessories {
    return Intl.message(
      'Mobile Accessories',
      name: 'category_mobile_accessories',
      desc: '',
      args: [],
    );
  }

  /// `Motorcycle`
  String get category_motorcycle {
    return Intl.message(
      'Motorcycle',
      name: 'category_motorcycle',
      desc: '',
      args: [],
    );
  }

  /// `Skin Care`
  String get category_skin_care {
    return Intl.message(
      'Skin Care',
      name: 'category_skin_care',
      desc: '',
      args: [],
    );
  }

  /// `Smartphones`
  String get category_smartphones {
    return Intl.message(
      'Smartphones',
      name: 'category_smartphones',
      desc: '',
      args: [],
    );
  }

  /// `Sports Accessories`
  String get category_sports_accessories {
    return Intl.message(
      'Sports Accessories',
      name: 'category_sports_accessories',
      desc: '',
      args: [],
    );
  }

  /// `Sunglasses`
  String get category_sunglasses {
    return Intl.message(
      'Sunglasses',
      name: 'category_sunglasses',
      desc: '',
      args: [],
    );
  }

  /// `Tablets`
  String get category_tablets {
    return Intl.message(
      'Tablets',
      name: 'category_tablets',
      desc: '',
      args: [],
    );
  }

  /// `Tops`
  String get category_tops {
    return Intl.message('Tops', name: 'category_tops', desc: '', args: []);
  }

  /// `Vehicle`
  String get category_vehicle {
    return Intl.message(
      'Vehicle',
      name: 'category_vehicle',
      desc: '',
      args: [],
    );
  }

  /// `Women's Bags`
  String get category_womens_bags {
    return Intl.message(
      'Women\'s Bags',
      name: 'category_womens_bags',
      desc: '',
      args: [],
    );
  }

  /// `Women's Dresses`
  String get category_womens_dresses {
    return Intl.message(
      'Women\'s Dresses',
      name: 'category_womens_dresses',
      desc: '',
      args: [],
    );
  }

  /// `Women's Jewellery`
  String get category_womens_jewellery {
    return Intl.message(
      'Women\'s Jewellery',
      name: 'category_womens_jewellery',
      desc: '',
      args: [],
    );
  }

  /// `Women's Shoes`
  String get category_womens_shoes {
    return Intl.message(
      'Women\'s Shoes',
      name: 'category_womens_shoes',
      desc: '',
      args: [],
    );
  }

  /// `Women's Watches`
  String get category_womens_watches {
    return Intl.message(
      'Women\'s Watches',
      name: 'category_womens_watches',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get about_me_title {
    return Intl.message('About me', name: 'about_me_title', desc: '', args: []);
  }

  /// `Summary`
  String get about_me_summary {
    return Intl.message(
      'Summary',
      name: 'about_me_summary',
      desc: '',
      args: [],
    );
  }

  /// `I am a Flutter Mobile Developer specialized in building high-performance cross-platform applications for Android and iOS using a single codebase. I focus on clean, scalable architectures and delivering smooth, user-friendly experiences.\n\nI have solid experience working with Firebase, REST APIs, and state management using Bloc/Cubit, with strong attention to detail and writing maintainable, production-ready code.`
  String get about_me_desc {
    return Intl.message(
      'I am a Flutter Mobile Developer specialized in building high-performance cross-platform applications for Android and iOS using a single codebase. I focus on clean, scalable architectures and delivering smooth, user-friendly experiences.\n\nI have solid experience working with Firebase, REST APIs, and state management using Bloc/Cubit, with strong attention to detail and writing maintainable, production-ready code.',
      name: 'about_me_desc',
      desc: '',
      args: [],
    );
  }

  /// `Technical Skills`
  String get about_me_technical_skills {
    return Intl.message(
      'Technical Skills',
      name: 'about_me_technical_skills',
      desc: '',
      args: [],
    );
  }

  /// `Apps I Can Build`
  String get about_me_apps_development {
    return Intl.message(
      'Apps I Can Build',
      name: 'about_me_apps_development',
      desc: '',
      args: [],
    );
  }

  /// `Flutter & Dart`
  String get about_me_skill_flutter {
    return Intl.message(
      'Flutter & Dart',
      name: 'about_me_skill_flutter',
      desc: '',
      args: [],
    );
  }

  /// `State Management (Bloc / Cubit)`
  String get about_me_skill_state_management {
    return Intl.message(
      'State Management (Bloc / Cubit)',
      name: 'about_me_skill_state_management',
      desc: '',
      args: [],
    );
  }

  /// `Firebase (Authentication – Firestore – Storage)`
  String get about_me_skill_firebase {
    return Intl.message(
      'Firebase (Authentication – Firestore – Storage)',
      name: 'about_me_skill_firebase',
      desc: '',
      args: [],
    );
  }

  /// `Working with REST APIs & Dio`
  String get about_me_skill_rest_api {
    return Intl.message(
      'Working with REST APIs & Dio',
      name: 'about_me_skill_rest_api',
      desc: '',
      args: [],
    );
  }

  /// `Clean Architecture & MVVM`
  String get about_me_skill_architecture {
    return Intl.message(
      'Clean Architecture & MVVM',
      name: 'about_me_skill_architecture',
      desc: '',
      args: [],
    );
  }

  /// `Responsive & Adaptive UI Design`
  String get about_me_skill_responsive_ui {
    return Intl.message(
      'Responsive & Adaptive UI Design',
      name: 'about_me_skill_responsive_ui',
      desc: '',
      args: [],
    );
  }

  /// `Localization (Arabic / English)`
  String get about_me_skill_localization {
    return Intl.message(
      'Localization (Arabic / English)',
      name: 'about_me_skill_localization',
      desc: '',
      args: [],
    );
  }

  /// `Git & GitHub`
  String get about_me_skill_git {
    return Intl.message(
      'Git & GitHub',
      name: 'about_me_skill_git',
      desc: '',
      args: [],
    );
  }

  /// `Custom UI Components & Performance Optimization`
  String get about_me_skill_custom_ui {
    return Intl.message(
      'Custom UI Components & Performance Optimization',
      name: 'about_me_skill_custom_ui',
      desc: '',
      args: [],
    );
  }

  /// `E-commerce Applications`
  String get about_me_app_ecommerce {
    return Intl.message(
      'E-commerce Applications',
      name: 'about_me_app_ecommerce',
      desc: '',
      args: [],
    );
  }

  /// `User & Employee Management Apps`
  String get about_me_app_management {
    return Intl.message(
      'User & Employee Management Apps',
      name: 'about_me_app_management',
      desc: '',
      args: [],
    );
  }

  /// `Chat & Messaging Applications`
  String get about_me_app_chat {
    return Intl.message(
      'Chat & Messaging Applications',
      name: 'about_me_app_chat',
      desc: '',
      args: [],
    );
  }

  /// `Content-based Applications (News – Blogs – Products)`
  String get about_me_app_content {
    return Intl.message(
      'Content-based Applications (News – Blogs – Products)',
      name: 'about_me_app_content',
      desc: '',
      args: [],
    );
  }

  /// `CRUD Applications with Firebase`
  String get about_me_app_firebase {
    return Intl.message(
      'CRUD Applications with Firebase',
      name: 'about_me_app_firebase',
      desc: '',
      args: [],
    );
  }

  /// `Multi-language Applications`
  String get about_me_app_multi_lang {
    return Intl.message(
      'Multi-language Applications',
      name: 'about_me_app_multi_lang',
      desc: '',
      args: [],
    );
  }

  /// `API-driven Mobile Applications`
  String get about_me_app_api {
    return Intl.message(
      'API-driven Mobile Applications',
      name: 'about_me_app_api',
      desc: '',
      args: [],
    );
  }

  /// `Admin Dashboards (Admin Panels)`
  String get about_me_app_admin {
    return Intl.message(
      'Admin Dashboards (Admin Panels)',
      name: 'about_me_app_admin',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get about_app_title {
    return Intl.message(
      'About App',
      name: 'about_app_title',
      desc: '',
      args: [],
    );
  }

  /// `Application Overview`
  String get about_app_summary_title {
    return Intl.message(
      'Application Overview',
      name: 'about_app_summary_title',
      desc: '',
      args: [],
    );
  }

  /// `This application is a modern e-commerce platform developed using Flutter to provide a fast and seamless shopping experience across Android and iOS using a single codebase. The app focuses on high performance, user-friendly navigation, and professional responsive UI design.\n\nIt provides a complete shopping journey including product browsing, cart management, order checkout, and multiple delivery options, with multi-language support and local data caching to ensure smooth performance and excellent user experience.`
  String get about_app_summary_desc {
    return Intl.message(
      'This application is a modern e-commerce platform developed using Flutter to provide a fast and seamless shopping experience across Android and iOS using a single codebase. The app focuses on high performance, user-friendly navigation, and professional responsive UI design.\n\nIt provides a complete shopping journey including product browsing, cart management, order checkout, and multiple delivery options, with multi-language support and local data caching to ensure smooth performance and excellent user experience.',
      name: 'about_app_summary_desc',
      desc: '',
      args: [],
    );
  }

  /// `Application Features`
  String get about_app_features_title {
    return Intl.message(
      'Application Features',
      name: 'about_app_features_title',
      desc: '',
      args: [],
    );
  }

  /// `Browse products in an organized and simple way`
  String get about_app_feature_products {
    return Intl.message(
      'Browse products in an organized and simple way',
      name: 'about_app_feature_products',
      desc: '',
      args: [],
    );
  }

  /// `Cart management with quantity control`
  String get about_app_feature_cart {
    return Intl.message(
      'Cart management with quantity control',
      name: 'about_app_feature_cart',
      desc: '',
      args: [],
    );
  }

  /// `Simple and clear checkout process`
  String get about_app_feature_checkout {
    return Intl.message(
      'Simple and clear checkout process',
      name: 'about_app_feature_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Multiple delivery options`
  String get about_app_feature_delivery {
    return Intl.message(
      'Multiple delivery options',
      name: 'about_app_feature_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Track order status`
  String get about_app_feature_orders {
    return Intl.message(
      'Track order status',
      name: 'about_app_feature_orders',
      desc: '',
      args: [],
    );
  }

  /// `Local caching for better performance`
  String get about_app_feature_local_storage {
    return Intl.message(
      'Local caching for better performance',
      name: 'about_app_feature_local_storage',
      desc: '',
      args: [],
    );
  }

  /// `Supports Arabic and English languages`
  String get about_app_feature_multi_lang {
    return Intl.message(
      'Supports Arabic and English languages',
      name: 'about_app_feature_multi_lang',
      desc: '',
      args: [],
    );
  }

  /// `Modern UI with smooth user experience`
  String get about_app_feature_ui {
    return Intl.message(
      'Modern UI with smooth user experience',
      name: 'about_app_feature_ui',
      desc: '',
      args: [],
    );
  }

  /// `Technologies Used`
  String get about_app_technical_title {
    return Intl.message(
      'Technologies Used',
      name: 'about_app_technical_title',
      desc: '',
      args: [],
    );
  }

  /// `Flutter & Dart`
  String get about_app_tech_flutter {
    return Intl.message(
      'Flutter & Dart',
      name: 'about_app_tech_flutter',
      desc: '',
      args: [],
    );
  }

  /// `State Management using Bloc / Cubit`
  String get about_app_tech_state_management {
    return Intl.message(
      'State Management using Bloc / Cubit',
      name: 'about_app_tech_state_management',
      desc: '',
      args: [],
    );
  }

  /// `Local Storage using Hive`
  String get about_app_tech_local_db {
    return Intl.message(
      'Local Storage using Hive',
      name: 'about_app_tech_local_db',
      desc: '',
      args: [],
    );
  }

  /// `Clean Architecture Implementation`
  String get about_app_tech_architecture {
    return Intl.message(
      'Clean Architecture Implementation',
      name: 'about_app_tech_architecture',
      desc: '',
      args: [],
    );
  }

  /// `REST API Integration`
  String get about_app_tech_api {
    return Intl.message(
      'REST API Integration',
      name: 'about_app_tech_api',
      desc: '',
      args: [],
    );
  }

  /// `Responsive design supporting multiple screen sizes`
  String get about_app_tech_responsive {
    return Intl.message(
      'Responsive design supporting multiple screen sizes',
      name: 'about_app_tech_responsive',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
