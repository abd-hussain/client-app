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
  int? id;
  String? firstName;
  String? lastName;
  String? invitationCode;
  String? profileImg;
  int? points;
  String? mobileNumber;
  String? email;
  int? gender;
  String? dateOfBirth;
  bool? allowNotifications;
  int? countryId;
  String? flagImage;
  String? countryName;
  String? currency;

  AccountInfoData(
      {this.id,
      this.firstName,
      this.lastName,
      this.invitationCode,
      this.profileImg,
      this.points,
      this.mobileNumber,
      this.email,
      this.gender,
      this.dateOfBirth,
      this.allowNotifications,
      this.countryId,
      this.flagImage,
      this.countryName,
      this.currency});

  AccountInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    invitationCode = json['invitation_code'];
    profileImg = json['profile_img'];
    points = json['points'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    allowNotifications = json['allow_notifications'];
    countryId = json['country_id'];
    flagImage = json['flag_image'];
    countryName = json['country_name'];
    currency = json['currency'];
  }
}
