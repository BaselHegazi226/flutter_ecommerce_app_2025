/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

PaymentResponseModel paymentResponseModelFromJson(String str) =>
    PaymentResponseModel.fromJson(json.decode(str));

String paymentResponseModelToJson(PaymentResponseModel data) =>
    json.encode(data.toJson());

class PaymentResponseModel {
  PaymentResponseModel({
    required this.created,
    required this.splitPaymentMethods,
    required this.extras,
    required this.intentionOrderId,
    required this.intentionDetail,
    required this.confirmed,
    required this.cardTokens,
    required this.paymentKeys,
    required this.paymentMethods,
    required this.id,
    required this.clientSecret,
    required this.status,
    required this.object,
  });

  final DateTime created;
  final List<dynamic> splitPaymentMethods;
  final Extras extras;
  final int intentionOrderId;
  final IntentionDetail intentionDetail;
  final bool confirmed;
  final List<dynamic> cardTokens;
  final List<PaymentKey> paymentKeys;
  final List<PaymentMethod> paymentMethods;
  final String id;
  final String clientSecret;
  final String status;
  final String object;

  factory PaymentResponseModel.fromJson(Map<dynamic, dynamic> json) =>
      PaymentResponseModel(
        created: DateTime.parse(json["created"]),
        splitPaymentMethods: List<dynamic>.from(
          json["split_payment_methods"].map((x) => x),
        ),
        extras: Extras.fromJson(json["extras"]),
        intentionOrderId: json["intention_order_id"],
        intentionDetail: IntentionDetail.fromJson(json["intention_detail"]),
        confirmed: json["confirmed"],
        cardTokens: List<dynamic>.from(json["card_tokens"].map((x) => x)),
        paymentKeys: List<PaymentKey>.from(
          json["payment_keys"].map((x) => PaymentKey.fromJson(x)),
        ),
        paymentMethods: List<PaymentMethod>.from(
          json["payment_methods"].map((x) => PaymentMethod.fromJson(x)),
        ),
        id: json["id"],
        clientSecret: json["client_secret"],
        status: json["status"],
        object: json["object"],
      );

  Map<dynamic, dynamic> toJson() => {
    "created": created.toIso8601String(),
    "split_payment_methods": List<dynamic>.from(
      splitPaymentMethods.map((x) => x),
    ),
    "extras": extras.toJson(),
    "intention_order_id": intentionOrderId,
    "intention_detail": intentionDetail.toJson(),
    "confirmed": confirmed,
    "card_tokens": List<dynamic>.from(cardTokens.map((x) => x)),
    "payment_keys": List<dynamic>.from(paymentKeys.map((x) => x.toJson())),
    "payment_methods": List<dynamic>.from(
      paymentMethods.map((x) => x.toJson()),
    ),
    "id": id,
    "client_secret": clientSecret,
    "status": status,
    "object": object,
  };
}

class Extras {
  Extras({required this.creationExtras});

  CreationExtras creationExtras;

  factory Extras.fromJson(Map<dynamic, dynamic> json) =>
      Extras(creationExtras: CreationExtras.fromJson(json["creation_extras"]));

  Map<dynamic, dynamic> toJson() => {
    "creation_extras": creationExtras.toJson(),
  };
}

class CreationExtras {
  CreationExtras({required this.ee});

  int ee;

  factory CreationExtras.fromJson(Map<dynamic, dynamic> json) =>
      CreationExtras(ee: json["ee"]);

  Map<dynamic, dynamic> toJson() => {"ee": ee};
}

class IntentionDetail {
  IntentionDetail({
    required this.billingData,
    required this.amount,
    required this.currency,
    required this.items,
  });

  BillingData billingData;
  int amount;
  String currency;
  List<Item> items;

  factory IntentionDetail.fromJson(Map<dynamic, dynamic> json) =>
      IntentionDetail(
        billingData: BillingData.fromJson(json["billing_data"]),
        amount: json["amount"],
        currency: json["currency"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
    "billing_data": billingData.toJson(),
    "amount": amount,
    "currency": currency,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class BillingData {
  BillingData({
    required this.country,
    required this.city,
    required this.lastName,
    required this.building,
    required this.street,
    required this.shippingMethod,
    required this.phoneNumber,
    required this.state,
    required this.floor,
    required this.postalCode,
    required this.firstName,
    required this.apartment,
    required this.email,
  });

  String country;
  String city;
  String lastName;
  String building;
  String street;
  String shippingMethod;
  String phoneNumber;
  String state;
  String floor;
  String postalCode;
  String firstName;
  String apartment;
  String email;

  factory BillingData.fromJson(Map<dynamic, dynamic> json) => BillingData(
    country: json["country"],
    city: json["city"],
    lastName: json["last_name"],
    building: json["building"],
    street: json["street"],
    shippingMethod: json["shipping_method"],
    phoneNumber: json["phone_number"],
    state: json["state"],
    floor: json["floor"],
    postalCode: json["postal_code"],
    firstName: json["first_name"],
    apartment: json["apartment"],
    email: json["email"],
  );

  Map<dynamic, dynamic> toJson() => {
    "country": country,
    "city": city,
    "last_name": lastName,
    "building": building,
    "street": street,
    "shipping_method": shippingMethod,
    "phone_number": phoneNumber,
    "state": state,
    "floor": floor,
    "postal_code": postalCode,
    "first_name": firstName,
    "apartment": apartment,
    "email": email,
  };
}

class Item {
  Item({
    required this.amount,
    required this.quantity,
    required this.name,
    required this.description,
  });

  int amount;
  int quantity;
  String name;
  String description;

  factory Item.fromJson(Map<dynamic, dynamic> json) => Item(
    amount: json["amount"],
    quantity: json["quantity"],
    name: json["name"],
    description: json["description"],
  );

  Map<dynamic, dynamic> toJson() => {
    "amount": amount,
    "quantity": quantity,
    "name": name,
    "description": description,
  };
}

class PaymentKey {
  PaymentKey({
    required this.saveCard,
    required this.integration,
    required this.gatewayType,
    required this.redirectionUrl,
    required this.orderId,
    required this.key,
  });

  bool saveCard;
  int integration;
  String gatewayType;
  String redirectionUrl;
  int orderId;
  String key;

  factory PaymentKey.fromJson(Map<dynamic, dynamic> json) => PaymentKey(
    saveCard: json["save_card"],
    integration: json["integration"],
    gatewayType: json["gateway_type"],
    redirectionUrl: json["redirection_url"],
    orderId: json["order_id"],
    key: json["key"],
  );

  Map<dynamic, dynamic> toJson() => {
    "save_card": saveCard,
    "integration": integration,
    "gateway_type": gatewayType,
    "redirection_url": redirectionUrl,
    "order_id": orderId,
    "key": key,
  };
}

class PaymentMethod {
  PaymentMethod({
    required this.integrationId,
    required this.useCvcWithMoto,
    required this.methodType,
    required this.currency,
    required this.live,
  });

  int integrationId;
  bool useCvcWithMoto;
  String methodType;
  String currency;
  bool live;

  factory PaymentMethod.fromJson(Map<dynamic, dynamic> json) => PaymentMethod(
    integrationId: json["integration_id"],
    useCvcWithMoto: json["use_cvc_with_moto"],
    methodType: json["method_type"],
    currency: json["currency"],
    live: json["live"],
  );

  Map<dynamic, dynamic> toJson() => {
    "integration_id": integrationId,
    "use_cvc_with_moto": useCvcWithMoto,
    "method_type": methodType,
    "currency": currency,
    "live": live,
  };
}
