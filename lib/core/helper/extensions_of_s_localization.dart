import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

extension AuthLocalizationX on S {
  // Common
  String get authEmail => auth_email;

  String get authPassword => auth_password;

  String get authConfirmPassword => auth_confirmPassword;

  String get authName => auth_name;

  String get authForgetPassword => auth_forgetPassword;

  String get authOr => auth_or;

  // Sign In
  String get authSignIn => auth_signIn;

  String get authSignInToContinue => auth_signInToContinue;

  String get authSignInWithGoogle => auth_signInWithGoogle;

  String get authSignInWithFacebook => auth_signInWithFacebook;

  // Sign Up
  String get authSignUp => auth_signUp;

  String get authSignUpToContinue => auth_signUpToContinue;

  // Validation
  String get authNameRequired => auth_nameRequired;

  String get authEmailRequired => auth_emailRequired;

  String get authPasswordRequired => auth_passwordRequired;

  String get authEnterValidName => auth_enterValidName;

  String get authEnterValidEmail => auth_enterValidEmail;

  String get authEnterStrongPassword => auth_enterStrongPassword;

  String get authPasswordNotMatch => auth_passwordNotMatch;
}

//main view extension of S
extension NavLocalizationX on S {
  String get navHome => nav_home;

  String get navSearch => nav_search;

  String get navCart => nav_cart;

  String get navProfile => nav_profile;
}

//home extension of S
extension HomeLocalizationX on S {
  String get homeWelcome => home_welcome;

  String get homeCategories => home_categories;

  String get homeAppProducts => home_app_products;

  String get homeShowAll => home_showAll;

  String get homeAllProducts => home_allProducts;

  String get homeCategory => home_category;

  String get homeRating => home_rating;

  String get homeDetails => home_details;

  String get homePrice => home_price;

  String get homeAddToCart => home_addToCart;

  String get homeNoProduct => home_no_products_now;

  String get homeNoCategory => home_not_categories_available_now;

  String get homeNoUserFound => home_not_user_found;
}

//Cart extension of S
extension CartLocalizationX on S {
  String get cartCheckout => cart_checkout;

  String get cartTotal => cart_total;

  String get cartDelivery => cart_delivery;

  String get cartLocation => cart_location;

  String get cartSummarize => cart_summarize;

  String get cartFinish => cart_finish;

  String get cartPayment => cart_payment;

  String get cartNextDayDelivery => cart_nextDayDelivery;

  String get cartNominatedDelivery => cart_nominatedDelivery;

  String get cartStandardDelivery => cart_standardDelivery;

  String get cartPlaceYourOrder => cart_placeYourOrder;

  String get cartPickAParticular => cart_pickAParticular;

  String get cartOrderWillBe => cart_orderWillBe;

  String get cartTryToFill => cart_tryToFill;

  String get cartAlreadyInCart => cart_alreadyInCart;
}

//order extension of S
extension OrderLocalizationX on S {
  String get orderPending => order_pending;

  String get orderDelivered => order_delivered;

  String get orderTransmit => order_transmit;

  String get orderReady => order_ready;

  String get orderCancel => order_cancel;

  String get orderNoLocation => order_noLocation;

  String get orderHistory => order_history;

  String get orderHistoryNoOrdersFound => order_history_no_found_orders;

  String get orderSelected => order_all;

  String get orderDeleteHistory => delete_order_history_title;

  String get orderOrderId => order_order_id;

  String deleteNumOfItems(BuildContext context, int num) {
    return '$order_delete $num $from $items';
  }

  String areYouSureToDeleteItems(BuildContext context, int num) {
    return '$delete_order_description $num $from $items';
  }
}

//form of location extension of S
extension FormLocalizationX on S {
  String get formStreet1 => form_street1;

  String get formStreet2 => form_street2;

  String get formCity => form_city;

  String get formState => form_state;

  String get formCountry => form_country;

  String get formCountryRequired => form_countryRequired;

  String get formEnterCountry => form_enterCountry;

  String get formStateRequired => form_stateRequired;

  String get formEnterState => form_enterState;

  String get formCityRequired => form_cityRequired;

  String get formEnterCity => form_enterCity;

  String get formStreet1Required => form_street1Required;

  String get formEnterStreet1 => form_enterStreet1;

  String get formStreet2Required => form_street2Required;

  String get formEnterStreet2 => form_enterStreet2;
}

//success extension of S

extension SuccessLocalizationX on S {
  // Login
  String get loginSuccessTitle => success_login_title;

  String get loginSuccessDesc => success_login_desc;

  // Register
  String get registerSuccessTitle => success_register_title;

  String get registerSuccessDesc => success_register_desc;

  // Cart
  String get addToCartSuccessTitle => success_addToCart_title;

  String get addToCartSuccessDesc => success_addToCart_desc;

  String get removeFromCartSuccessTitle => success_removeFromCart_title;

  String get removeFromCartSuccessDesc => success_removeFromCart_desc;

  // Payment
  String get paymentSuccessTitle => success_payment_title;

  String get paymentSuccessDesc => success_payment_desc;

  // Profile
  String get updateProfileSuccessTitle => success_updateProfile_title;

  String get updateProfileSuccessDesc => success_updateProfile_desc;

  // Favorites
  String get removeFavoriteSuccessTitle => success_removeFavorite_title;

  String get removeFavoriteSuccessDesc => success_removeFavorite_desc;

  String get clearFavoritesSuccessTitle => success_clearFavorites_title;

  String get clearFavoritesSuccessDesc => success_clearFavorites_desc;

  String get profileDeleteItemTitle => profile_delete_favourite_Item_title;

  String get profileDeleteItemDesc => profile_delete_favourite_Item_desc;

  String get profileLogoutTitle => profile_logout_title;

  String get profileLogoutDesc => profile_logout_desc;

  String get profileUpdateTitleButton => profile_update_title_button;

  // Orders
  String get removeOrderSuccessTitle => success_removeOrder_title;

  String get removeOrderSuccessDesc => success_removeOrder_desc;

  String get cancelOrderSuccessTitle => success_cancelOrder_title;

  String get cancelOrderSuccessDesc => success_cancelOrder_desc;

  // Logout
  String get logoutSuccessTitle => success_logout_title;

  String get logoutSuccessDesc => success_logout_desc;
}

//error extension of S
extension ErrorLocalizationX on S {
  String error(String key) {
    switch (key) {
      case 'error_connectionTimeout':
        return error_connectionTimeout;
      case 'error_sendTimeout':
        return error_sendTimeout;
      case 'error_receiveTimeout':
        return error_receiveTimeout;
      case 'error_connection':
        return error_connection;
      case 'error_unexpected':
        return error_unexpected;
      case 'error_unknownServer':
        return error_unknownServer;

      case 'error_badRequest':
        return error_badRequest;
      case 'error_unauthorized':
        return error_unauthorized;
      case 'error_forbidden':
        return error_forbidden;
      case 'error_notFound':
        return error_notFound;
      case 'error_conflict':
        return error_conflict;
      case 'error_internalServer':
        return error_internalServer;

      case 'error_networkRequestFailed':
        return error_networkRequestFailed;
      case 'error_tooManyRequests':
        return error_tooManyRequests;
      case 'error_userNotFound':
        return error_userNotFound;
      case 'error_wrongPassword':
        return error_wrongPassword;
      case 'error_emailAlreadyInUse':
        return error_emailAlreadyInUse;
      case 'error_invalidEmail':
        return error_invalidEmail;
      case 'error_weakPassword':
        return error_weakPassword;
      case 'error_operationNotAllowed':
        return error_operationNotAllowed;
      case 'error_userDisabled':
        return error_userDisabled;
      case 'error_requiresRecentLogin':
        return error_requiresRecentLogin;
      case 'error_invalidVerificationCode':
        return error_invalidVerificationCode;
      case 'error_invalidVerificationId':
        return error_invalidVerificationId;

      default:
        return error_unknownFirebase;
    }
  }
}

extension FailureLocalizationX on S {
  String get loginFailureTitle => failure_login_title;

  String get registerFailureTitle => failure_register_title;

  String get addOrderFailureTitle => failure_addOrder_title;

  String get addToCartFailureTitle => failure_addToCart_title;

  String get paymentFailureTitle => failure_payment_title;

  String get updateProfileFailureTitle => failure_updateProfile_title;
}

//setting extension of S
extension SettingsLocalizationX on S {
  String get settingsTitle => settings_title;

  String get settingsNotifications => settings_notifications;

  String get settingsMode => settings_mode;

  String get settingsLanguage => settings_language;

  String get settingsOnOff => settings_onOff;

  String get settingsDark => settings_dark;

  String get settingsLight => settings_light;

  String get settingsLogout => settings_logout;
}

//profile extension of S
extension ProfileLocalizationX on S {
  String get profileEdit => profile_edit;

  String get profileShippingAddress => profile_shippingAddress;

  String get profileNoShippingAddress => profile_no_shipping_address;

  String get profileFavourite => profile_favourite;

  String get profileNoFavourite => profile_noFavourite;

  String get profileUserName => profile_userName;

  String get profileUserEmail => profile_userEmail;
}

//About me extenstion of s
extension AboutMeLocaliztionX on S {
  String get aboutMeTitle => about_me_title;

  String get aboutMeDesc => about_me_desc;

  String get aboutMeSummary => about_me_summary;

  String get aboutMeTechnicalSkills => about_me_technical_skills;

  String get aboutMeAppsDevelopment => about_me_apps_development;

  /// Skills
  String get aboutMeSkillFlutter => about_me_skill_flutter;

  String get aboutMeSkillStateManagement => about_me_skill_state_management;

  String get aboutMeSkillFirebase => about_me_skill_firebase;

  String get aboutMeSkillRestApi => about_me_skill_rest_api;

  String get aboutMeSkillArchitecture => about_me_skill_architecture;

  String get aboutMeSkillResponsiveUi => about_me_skill_responsive_ui;

  String get aboutMeSkillLocalization => about_me_skill_localization;

  String get aboutMeSkillGit => about_me_skill_git;

  String get aboutMeSkillCustomUi => about_me_skill_custom_ui;

  /// Apps
  String get aboutMeAppEcommerce => about_me_app_ecommerce;

  String get aboutMeAppManagement => about_me_app_management;

  String get aboutMeAppChat => about_me_app_chat;

  String get aboutMeAppContent => about_me_app_content;

  String get aboutMeAppFirebase => about_me_app_firebase;

  String get aboutMeAppMultilang => about_me_app_multi_lang;

  String get aboutMeAppApi => about_me_app_api;

  String get aboutMeAppAdmin => about_me_app_admin;
}

//category

extension CategoryLocalizationX on S {
  String categoryFunction(String category) {
    switch (category) {
      case 'beauty':
        return categoryBeauty;
      case 'fragrances':
        return categoryFragrances;
      case 'furniture':
        return categoryFurniture;
      case 'groceries':
        return categoryGroceries;
      case 'home-decoration':
        return categoryHomeDecoration;
      case 'kitchen-accessories':
        return categoryKitchenAccessories;
      case 'laptops':
        return categoryLaptops;

      case 'mens-shirts':
        return categoryMensShirts;
      case 'mens-shoes':
        return categoryMensShoes;
      case 'mens-watches':
        return categoryMensWatches;

      case 'mobile-accessories':
        return categoryMobileAccessories;
      case 'motorcycle':
        return categoryMotorcycle;
      case 'skin-care':
        return categorySkinCare;
      case 'smartphones':
        return categorySmartphones;
      case 'sports-accessories':
        return categorySportsAccessories;
      case 'sunglasses':
        return categorySunglasses;
      case 'tablets':
        return categoryTablets;
      case 'tops':
        return categoryTops;
      case 'vehicle':
        return categoryVehicle;

      case 'womens-bags':
        return categoryWomensBags;
      case 'womens-dresses':
        return categoryWomensDresses;
      case 'womens-jewellery':
        return categoryWomensJewellery;
      case 'womens-shoes':
        return categoryWomensShoes;
      case 'womens-watches':
        return categoryWomensWatches;

      default:
        return category; // fallback لو API رجّعت category جديدة
    }
  }

  // ===== getters (لازم تكون موجودة) =====

  String get categoryBeauty => category_beauty;

  String get categoryFragrances => category_fragrances;

  String get categoryFurniture => category_furniture;

  String get categoryGroceries => category_groceries;

  String get categoryHomeDecoration => category_home_decoration;

  String get categoryKitchenAccessories => category_kitchen_accessories;

  String get categoryLaptops => category_laptops;

  String get categoryMensShirts => category_mens_shirts;

  String get categoryMensShoes => category_mens_shoes;

  String get categoryMensWatches => category_mens_watches;

  String get categoryMobileAccessories => category_mobile_accessories;

  String get categoryMotorcycle => category_motorcycle;

  String get categorySkinCare => category_skin_care;

  String get categorySmartphones => category_smartphones;

  String get categorySportsAccessories => category_sports_accessories;

  String get categorySunglasses => category_sunglasses;

  String get categoryTablets => category_tablets;

  String get categoryTops => category_tops;

  String get categoryVehicle => category_vehicle;

  String get categoryWomensBags => category_womens_bags;

  String get categoryWomensDresses => category_womens_dresses;

  String get categoryWomensJewellery => category_womens_jewellery;

  String get categoryWomensShoes => category_womens_shoes;

  String get categoryWomensWatches => category_womens_watches;
}
