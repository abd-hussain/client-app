class MentorInfoResponse {
  MentorInfoResponseData? data;
  String? message;

  MentorInfoResponse({this.data, this.message});

  MentorInfoResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? MentorInfoResponseData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class MentorInfoResponseData {
  int? id;
  String? suffixeName;
  String? firstName;
  String? lastName;
  int? gender;
  String? profileImg;
  double? hourRateByJD;
  String? bio;
  String? dateOfBirth;

  MentorInfoResponseData({
    this.id,
    this.suffixeName,
    this.firstName,
    this.lastName,
    this.gender,
    this.profileImg,
    this.hourRateByJD,
    this.bio,
    this.dateOfBirth,
  });

  MentorInfoResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    profileImg = json['profile_img'];
    hourRateByJD = json['hour_rate_by_JD'];
    bio = json['bio'];
    dateOfBirth = json['date_of_birth'];
  }
}
