import 'package:client_app/utils/constants/constant.dart';

class AccountInfo {
  AccountInfoData? data;
  String? message;

  AccountInfo({data, message});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AccountInfoData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class AccountInfoData {
  String? mobileNumber;
  String? osType;
  int? countryId;
  String? email;
  String? deviceTypeName;
  String? createdAt;
  int? gender;
  String? osVersion;
  bool? allowNotifications;
  String? appVersion;
  bool? blocked;
  String? dateOfBirth;
  String? firstName;
  String? referalCode;
  String? lastUsage;
  int? id;
  String? invitationCode;
  String? lastOtp;
  String? lastName;
  String? profileImg;
  String? apiKey;

  AccountInfoData(
      {mobileNumber,
      osType,
      countryId,
      email,
      deviceTypeName,
      createdAt,
      gender,
      osVersion,
      allowNotifications,
      appVersion,
      blocked,
      dateOfBirth,
      firstName,
      referalCode,
      lastUsage,
      id,
      invitationCode,
      lastOtp,
      lastName,
      profileImg,
      apiKey});

  AccountInfoData.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    osType = json['os_type'];
    countryId = json['country_id'];
    email = json['email'];
    deviceTypeName = json['device_type_name'];
    createdAt = json['created_at'];
    gender = json['gender'];
    osVersion = json['os_version'];
    allowNotifications = json['allow_notifications'];
    appVersion = json['app_version'];
    blocked = json['blocked'];
    dateOfBirth = json['date_of_birth'];
    firstName = json['first_name'];
    referalCode = json['referal_code'];
    lastUsage = json['last_usage'];
    id = json['id'];
    invitationCode = json['invitation_code'];
    lastOtp = json['last_otp'];
    lastName = json['last_name'];
    profileImg = AppConstant.imagesBaseURLForMentors + json['profile_img'];
    apiKey = json['api_key'];
  }
}
