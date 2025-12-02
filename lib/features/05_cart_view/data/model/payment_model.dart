class PaymentModel {
  final String userEmail;
  final String userName;
  final String userLastName;
  final String userPhone;

  final String integrationMobileWalletId;
  final String integrationCardId;
  final String iframeId;
  final String apiKey;

  PaymentModel({
    required this.userEmail,
    required this.userName,
    required this.userLastName,
    required this.userPhone,
    required this.integrationMobileWalletId,
    required this.integrationCardId,
    required this.iframeId,
    required this.apiKey,
  });
  factory PaymentModel.fromJson(Map<String, dynamic> jsonData) {
    return PaymentModel(
      userEmail: jsonData['userEmail'],
      userName: jsonData['userName'],
      userLastName: jsonData['userLastName'],
      userPhone: jsonData['userPhone'],
      integrationMobileWalletId: jsonData['integrationMobileWalletId'],
      integrationCardId: jsonData['integrationCardId'],
      iframeId: jsonData['iframeId'],
      apiKey: jsonData['apiKey'],
    );
  }
  toJson() {
    return {
      'userEmail': userEmail,
      'userName': userName,
      'userLastName': userLastName,
      'userPhone': userPhone,
      'integrationCardId': integrationCardId,
      'iframeId': iframeId,
      'integrationMobileWalletId': integrationCardId,
      'apiKey': apiKey,
    };
  }

  copyWith({
    required String? newUserEmail,
    required String? newUserName,
    required String? newUserLastName,
    required String? newUserPhone,
    required String? newIntegrationMobileWalletId,
    required String? newIntegrationCardId,
    required String? newIframe,
    required String? newApiKey,
  }) {
    return PaymentModel(
      userEmail: newUserEmail ?? userEmail,
      userName: newUserName ?? userName,
      userLastName: newUserLastName ?? userLastName,
      userPhone: newUserPhone ?? userPhone,
      integrationMobileWalletId:
          newIntegrationMobileWalletId ?? integrationMobileWalletId,
      integrationCardId: newIntegrationCardId ?? integrationCardId,
      iframeId: newIframe ?? iframeId,
      apiKey: newApiKey ?? apiKey,
    );
  }
}
