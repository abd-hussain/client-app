class AccountInfo {
  AccountInfoData? data;
  String? message;

  AccountInfo({data, message});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AccountInfoData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['data'] = this.data!.toJson();
    data['message'] = message;
    return data;
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
    profileImg = json['profile_img'];
    apiKey = json['api_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_number'] = mobileNumber;
    data['os_type'] = osType;
    data['country_id'] = countryId;
    data['email'] = email;
    data['device_type_name'] = deviceTypeName;
    data['created_at'] = createdAt;
    data['gender'] = gender;
    data['os_version'] = osVersion;
    data['allow_notifications'] = allowNotifications;
    data['app_version'] = appVersion;
    data['blocked'] = blocked;
    data['date_of_birth'] = dateOfBirth;
    data['first_name'] = firstName;
    data['referal_code'] = referalCode;
    data['last_usage'] = lastUsage;
    data['id'] = id;
    data['invitation_code'] = invitationCode;
    data['last_otp'] = lastOtp;
    data['last_name'] = lastName;
    data['profile_img'] = profileImg;
    data['api_key'] = apiKey;
    return data;
  }
}
