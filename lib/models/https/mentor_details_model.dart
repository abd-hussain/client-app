class MentorDetailsResponse {
  MentorDetailsResponseData? data;
  String? message;

  MentorDetailsResponse({this.data, this.message});

  MentorDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? MentorDetailsResponseData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class MentorDetailsResponseData {
  int? classMin;
  String? invitationCode;
  String? createdAt;
  double? hourRateByJD;
  String? profileImg;
  int? categoryId;
  double? rate;
  String? appVersion;
  int? id;
  String? mobileNumber;
  String? dateOfBirth;
  String? suffixeName;
  String? email;
  String? lastUsage;
  String? firstName;
  int? gender;
  String? lastOtp;
  String? lastName;
  bool? blocked;
  String? apiKey;
  String? referalCode;
  int? countryId;

  MentorDetailsResponseData(
      {this.classMin,
      this.invitationCode,
      this.createdAt,
      this.hourRateByJD,
      this.profileImg,
      this.categoryId,
      this.rate,
      this.appVersion,
      this.id,
      this.mobileNumber,
      this.dateOfBirth,
      this.suffixeName,
      this.email,
      this.lastUsage,
      this.firstName,
      this.gender,
      this.lastOtp,
      this.lastName,
      this.blocked,
      this.apiKey,
      this.referalCode,
      this.countryId});

  MentorDetailsResponseData.fromJson(Map<String, dynamic> json) {
    classMin = json['class_min'];
    invitationCode = json['invitation_code'];
    createdAt = json['created_at'];
    hourRateByJD = json['hour_rate_by_JD'];
    profileImg = json['profile_img'];
    categoryId = json['category_id'];
    rate = json['rate'];
    appVersion = json['app_version'];
    id = json['id'];
    mobileNumber = json['mobile_number'];
    dateOfBirth = json['date_of_birth'];
    suffixeName = json['suffixe_name'];
    email = json['email'];
    lastUsage = json['last_usage'];
    firstName = json['first_name'];
    gender = json['gender'];
    lastOtp = json['last_otp'];
    lastName = json['last_name'];
    blocked = json['blocked'];
    apiKey = json['api_key'];
    referalCode = json['referal_code'];
    countryId = json['country_id'];
  }
}
