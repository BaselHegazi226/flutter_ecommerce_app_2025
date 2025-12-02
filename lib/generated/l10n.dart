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

  /// `Home`
  String get Home {
    return Intl.message('Home', name: 'Home', desc: '', args: []);
  }

  /// `Search`
  String get Search {
    return Intl.message('Search', name: 'Search', desc: '', args: []);
  }

  /// `Cart`
  String get Cart {
    return Intl.message('Cart', name: 'Cart', desc: '', args: []);
  }

  /// `Profile`
  String get Profile {
    return Intl.message('Profile', name: 'Profile', desc: '', args: []);
  }

  /// `Welcome`
  String get Welcome {
    return Intl.message('Welcome', name: 'Welcome', desc: '', args: []);
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message('Sign Up', name: 'SignUp', desc: '', args: []);
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message('Sign In', name: 'SignIn', desc: '', args: []);
  }

  /// `Sign in to Continue`
  String get SignIntoContinue {
    return Intl.message(
      'Sign in to Continue',
      name: 'SignIntoContinue',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to Continue`
  String get SignUpToContinue {
    return Intl.message(
      'Sign up to Continue',
      name: 'SignUpToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message('Email', name: 'Email', desc: '', args: []);
  }

  /// `email`
  String get email {
    return Intl.message('email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get Password {
    return Intl.message('Password', name: 'Password', desc: '', args: []);
  }

  /// `Forget Password`
  String get ForgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'ForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `_Or_`
  String get Or {
    return Intl.message('_Or_', name: 'Or', desc: '', args: []);
  }

  /// `Sign In with Google`
  String get SignInWithGoogle {
    return Intl.message(
      'Sign In with Google',
      name: 'SignInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign In with Facebook`
  String get SignInWithFacebook {
    return Intl.message(
      'Sign In with Facebook',
      name: 'SignInWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message('Name', name: 'Name', desc: '', args: []);
  }

  /// `name`
  String get name {
    return Intl.message('name', name: 'name', desc: '', args: []);
  }

  /// `name is required`
  String get nameIsRequired {
    return Intl.message(
      'name is required',
      name: 'nameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `email is required`
  String get emailIsRequired {
    return Intl.message(
      'email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `enter valid name`
  String get enterValidName {
    return Intl.message(
      'enter valid name',
      name: 'enterValidName',
      desc: '',
      args: [],
    );
  }

  /// `enter valid email (email@gmail.com)`
  String get enterValidEmail {
    return Intl.message(
      'enter valid email (email@gmail.com)',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `password is required`
  String get passwordIsRequired {
    return Intl.message(
      'password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `enter strong password`
  String get enterStrongPassword {
    return Intl.message(
      'enter strong password',
      name: 'enterStrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message('Categories', name: 'Categories', desc: '', args: []);
  }

  /// `Best Selling`
  String get BestSelling {
    return Intl.message(
      'Best Selling',
      name: 'BestSelling',
      desc: '',
      args: [],
    );
  }

  /// `Billing address is the same as delivery address`
  String get BillingAddress {
    return Intl.message(
      'Billing address is the same as delivery address',
      name: 'BillingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get ShowAll {
    return Intl.message('Show All', name: 'ShowAll', desc: '', args: []);
  }

  /// `All Products`
  String get AllProducts {
    return Intl.message(
      'All Products',
      name: 'AllProducts',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get Category {
    return Intl.message('Category', name: 'Category', desc: '', args: []);
  }

  /// `Rating`
  String get Rating {
    return Intl.message('Rating', name: 'Rating', desc: '', args: []);
  }

  /// `Details`
  String get Details {
    return Intl.message('Details', name: 'Details', desc: '', args: []);
  }

  /// `Price`
  String get Price {
    return Intl.message('Price', name: 'Price', desc: '', args: []);
  }

  /// `Add To Cart`
  String get AddToCart {
    return Intl.message('Add To Cart', name: 'AddToCart', desc: '', args: []);
  }

  /// `CHECKOUT`
  String get Checkout {
    return Intl.message('CHECKOUT', name: 'Checkout', desc: '', args: []);
  }

  /// `Total`
  String get Total {
    return Intl.message('Total', name: 'Total', desc: '', args: []);
  }

  /// `Delivery`
  String get Delivery {
    return Intl.message('Delivery', name: 'Delivery', desc: '', args: []);
  }

  /// `Location`
  String get Location {
    return Intl.message('Location', name: 'Location', desc: '', args: []);
  }

  /// `Summarize`
  String get Summarize {
    return Intl.message('Summarize', name: 'Summarize', desc: '', args: []);
  }

  /// `Finish`
  String get Finish {
    return Intl.message('Finish', name: 'Finish', desc: '', args: []);
  }

  /// `Next Day Delivery`
  String get NextDayDelivery {
    return Intl.message(
      'Next Day Delivery',
      name: 'NextDayDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Nominated Delivery`
  String get NominatedDelivery {
    return Intl.message(
      'Nominated Delivery',
      name: 'NominatedDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Standard Delivery`
  String get StandardDelivery {
    return Intl.message(
      'Standard Delivery',
      name: 'StandardDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Place your order before 6pm and your items will be delivered the next day`
  String get PlaceYourOrder {
    return Intl.message(
      'Place your order before 6pm and your items will be delivered the next day',
      name: 'PlaceYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Pick a particular date from the calendar and order will be delivered on selected date`
  String get PickAParticular {
    return Intl.message(
      'Pick a particular date from the calendar and order will be delivered on selected date',
      name: 'PickAParticular',
      desc: '',
      args: [],
    );
  }

  /// `Order will be delivered between 3 - 5 business days`
  String get OrderWillBe {
    return Intl.message(
      'Order will be delivered between 3 - 5 business days',
      name: 'OrderWillBe',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message('Next', name: 'Next', desc: '', args: []);
  }

  /// `Back`
  String get Back {
    return Intl.message('Back', name: 'Back', desc: '', args: []);
  }

  /// `Street 1`
  String get Street1 {
    return Intl.message('Street 1', name: 'Street1', desc: '', args: []);
  }

  /// `Street 2`
  String get Street2 {
    return Intl.message('Street 2', name: 'Street2', desc: '', args: []);
  }

  /// `City`
  String get City {
    return Intl.message('City', name: 'City', desc: '', args: []);
  }

  /// `State`
  String get State {
    return Intl.message('State', name: 'State', desc: '', args: []);
  }

  /// `Country`
  String get Country {
    return Intl.message('Country', name: 'Country', desc: '', args: []);
  }

  /// `Total Price`
  String get TotalPrice {
    return Intl.message('Total Price', name: 'TotalPrice', desc: '', args: []);
  }

  /// `Deliver`
  String get Deliver {
    return Intl.message('Deliver', name: 'Deliver', desc: '', args: []);
  }

  /// `Pending`
  String get Pending {
    return Intl.message('Pending', name: 'Pending', desc: '', args: []);
  }

  /// `Delivered`
  String get Delivered {
    return Intl.message('Delivered', name: 'Delivered', desc: '', args: []);
  }

  /// `Transmit`
  String get Transmit {
    return Intl.message('Transmit', name: 'Transmit', desc: '', args: []);
  }

  /// `Order is Ready To Make`
  String get OrderIsReady {
    return Intl.message(
      'Order is Ready To Make',
      name: 'OrderIsReady',
      desc: '',
      args: [],
    );
  }

  /// `Try To Fill Cart`
  String get TryToFillCart {
    return Intl.message(
      'Try To Fill Cart',
      name: 'TryToFillCart',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get EditProfile {
    return Intl.message(
      'Edit Profile',
      name: 'EditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get ShippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'ShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Order History`
  String get OrderHistory {
    return Intl.message(
      'Order History',
      name: 'OrderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get Favourite {
    return Intl.message('Favourite', name: 'Favourite', desc: '', args: []);
  }

  /// `Settings`
  String get Settings {
    return Intl.message('Settings', name: 'Settings', desc: '', args: []);
  }

  /// `Logout`
  String get Logout {
    return Intl.message('Logout', name: 'Logout', desc: '', args: []);
  }

  /// `No Favourite Item Found`
  String get NoFavouriteItemFound {
    return Intl.message(
      'No Favourite Item Found',
      name: 'NoFavouriteItemFound',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get Mode {
    return Intl.message('Mode', name: 'Mode', desc: '', args: []);
  }

  /// `Language`
  String get Language {
    return Intl.message('Language', name: 'Language', desc: '', args: []);
  }

  /// `country is required`
  String get countryIsRequired {
    return Intl.message(
      'country is required',
      name: 'countryIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter country`
  String get enterCountry {
    return Intl.message(
      'Enter country',
      name: 'enterCountry',
      desc: '',
      args: [],
    );
  }

  /// `state is required`
  String get stateIsRequired {
    return Intl.message(
      'state is required',
      name: 'stateIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter state`
  String get enterState {
    return Intl.message('Enter state', name: 'enterState', desc: '', args: []);
  }

  /// `Enter city`
  String get enterCity {
    return Intl.message('Enter city', name: 'enterCity', desc: '', args: []);
  }

  /// `city is required`
  String get cityIsRequired {
    return Intl.message(
      'city is required',
      name: 'cityIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `street 2 is required`
  String get street2IsRequired {
    return Intl.message(
      'street 2 is required',
      name: 'street2IsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter street 2`
  String get enterStreet2 {
    return Intl.message(
      'Enter street 2',
      name: 'enterStreet2',
      desc: '',
      args: [],
    );
  }

  /// `street 1 is required`
  String get street1IsRequired {
    return Intl.message(
      'street 1 is required',
      name: 'street1IsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter street 1`
  String get enterStreet1 {
    return Intl.message(
      'Enter street 1',
      name: 'enterStreet1',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get CancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'CancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `'No Location Found try make order!`
  String get NoLocation {
    return Intl.message(
      '\'No Location Found try make order!',
      name: 'NoLocation',
      desc: '',
      args: [],
    );
  }

  /// `On / Off`
  String get OnOff {
    return Intl.message('On / Off', name: 'OnOff', desc: '', args: []);
  }

  /// `Dark`
  String get Dark {
    return Intl.message('Dark', name: 'Dark', desc: '', args: []);
  }

  /// `Light`
  String get Light {
    return Intl.message('Light', name: 'Light', desc: '', args: []);
  }

  /// `User Name`
  String get UserName {
    return Intl.message('User Name', name: 'UserName', desc: '', args: []);
  }

  /// `User Email`
  String get UserEmail {
    return Intl.message('User Email', name: 'UserEmail', desc: '', args: []);
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
