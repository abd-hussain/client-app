import 'package:client_app/utils/mixins.dart';

class AuthRequest implements Model {
  String mobileNumber;
  int countryId;
  String appVersion;

  AuthRequest({
    required this.mobileNumber,
    required this.appVersion,
    required this.countryId,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['mobile_number'] = mobileNumber;
    data['app_version'] = appVersion;
    data['country_id'] = countryId;
    return data;
  }
}

class VerifyOTPrequest implements Model {
  String? mobileNumber;
  String? otp;
  String? apiKey;
  int? userId;

  VerifyOTPrequest({this.mobileNumber, this.otp, this.apiKey, this.userId});

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['mobile_number'] = mobileNumber;
    data['otp'] = otp;
    data['api_key'] = apiKey;
    data['user_id'] = userId;
    return data;
  }
}
