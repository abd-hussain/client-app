class AuthResponse {
  AuthResponseData? data;
  String? message;

  AuthResponse({this.data, this.message});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? AuthResponseData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class AuthResponseData {
  int? id;
  String? apiKey;
  bool? blocked;
  String? firstName;
  String? lastName;
  String? lastOtp;

  AuthResponseData({
    this.id,
    this.apiKey,
    this.blocked,
    this.firstName,
    this.lastName,
    this.lastOtp,
  });

  AuthResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apiKey = json['api_key'];
    blocked = json['blocked'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    lastOtp = json['last_otp'];
  }
}

class VerifyOTPResponse {
  VerifyOTPResponseData? data;
  String? message;

  VerifyOTPResponse({this.data, this.message});

  VerifyOTPResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? VerifyOTPResponseData.fromJson(json['data'])
        : null;
    message = json['message'];
  }
}

class VerifyOTPResponseData {
  String? token;
  String? tokenType;

  VerifyOTPResponseData({this.token, this.tokenType});

  VerifyOTPResponseData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['token_type'];
  }
}
