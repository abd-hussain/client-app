import 'package:client_app/utils/mixins.dart';

class AuthDebugRequest implements Model {
  String mobileNumber;
  int countryId;
  String appVersion;

  AuthDebugRequest({
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
  String? osType;
  String? deviceTypeName;
  String? osVersion;
  String? appVersion;
  int? countryId;
  String? otp;
  String? apiKey;
  int? userId;

  VerifyOTPrequest(
      {this.mobileNumber,
      this.osType,
      this.deviceTypeName,
      this.osVersion,
      this.appVersion,
      this.countryId,
      this.otp,
      this.apiKey,
      this.userId});

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['mobile_number'] = mobileNumber;
    data['os_type'] = osType;
    data['device_type_name'] = deviceTypeName;
    data['os_version'] = osVersion;
    data['app_version'] = appVersion;
    data['country_id'] = countryId;
    data['otp'] = otp;
    data['api_key'] = apiKey;
    data['user_id'] = userId;
    return data;
  }
}
