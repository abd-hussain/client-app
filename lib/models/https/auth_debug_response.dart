class AuthDebugResponse {
  AuthDebugResponseData? data;
  String? message;
  String? requestId;

  AuthDebugResponse({this.data, this.message, this.requestId});

  AuthDebugResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? AuthDebugResponseData.fromJson(json['data'])
        : null;
    message = json['message'];
    requestId = json['request_id'];
  }
}

class AuthDebugResponseData {
  int? id;
  String? apiKey;
  bool? blocked;
  String? firstName;
  String? lastName;

  String? lastOtp;

  AuthDebugResponseData(
      {this.id,
      this.apiKey,
      this.blocked,
      this.firstName,
      this.lastName,
      this.lastOtp});

  AuthDebugResponseData.fromJson(Map<String, dynamic> json) {
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
