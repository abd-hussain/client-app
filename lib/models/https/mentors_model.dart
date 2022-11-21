class MentorsModel {
  List<MentorsModelData>? data;
  String? message;

  MentorsModel({this.data, this.message});

  MentorsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MentorsModelData>[];
      json['data'].forEach((v) {
        data!.add(MentorsModelData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class MentorsModelData {
  String? lastName;
  int? id;
  String? email;
  bool? blocked;
  String? invitationCode;
  String? appVersion;
  String? lastUsage;
  String? apiKey;
  String? createdAt;
  String? mobileNumber;
  int? categoryId;
  String? firstName;
  int? gender;
  String? referalCode;
  String? profileImg;
  String? dateOfBirth;
  String? lastOtp;
  int? countryId;

  MentorsModelData(
      {this.lastName,
      this.id,
      this.email,
      this.blocked,
      this.invitationCode,
      this.appVersion,
      this.lastUsage,
      this.apiKey,
      this.createdAt,
      this.mobileNumber,
      this.categoryId,
      this.firstName,
      this.gender,
      this.referalCode,
      this.profileImg,
      this.dateOfBirth,
      this.lastOtp,
      this.countryId});

  MentorsModelData.fromJson(Map<String, dynamic> json) {
    lastName = json['last_name'];
    id = json['id'];
    email = json['email'];
    blocked = json['blocked'];
    invitationCode = json['invitation_code'];
    appVersion = json['app_version'];
    lastUsage = json['last_usage'];
    apiKey = json['api_key'];
    createdAt = json['created_at'];
    mobileNumber = json['mobile_number'];
    categoryId = json['category_id'];
    firstName = json['first_name'];
    gender = json['gender'];
    referalCode = json['referal_code'];
    profileImg = json['profile_img'];
    dateOfBirth = json['date_of_birth'];
    lastOtp = json['last_otp'];
    countryId = json['country_id'];
  }
}
