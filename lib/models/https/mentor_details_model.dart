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
  String? suffixeName;
  String? firstName;
  String? lastName;
  String? bio;
  List<String>? speakingLanguage;
  int? classMin;
  double? hourRateByJD;
  double? rate;
  int? gender;
  String? profileImg;
  String? dateOfBirth;
  String? categoryName;
  String? country;
  String? countryFlag;
  List<String>? major;

  MentorDetailsResponseData(
      {this.suffixeName,
      this.firstName,
      this.lastName,
      this.bio,
      this.speakingLanguage,
      this.classMin,
      this.hourRateByJD,
      this.rate,
      this.gender,
      this.profileImg,
      this.dateOfBirth,
      this.categoryName,
      this.country,
      this.countryFlag,
      this.major});

  MentorDetailsResponseData.fromJson(Map<String, dynamic> json) {
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    bio = json['bio'];
    speakingLanguage = json['speaking_language'].cast<String>();
    classMin = json['class_min'];
    hourRateByJD = json['hour_rate_by_JD'];
    rate = json['rate'];
    gender = json['gender'];
    profileImg = json['profile_img'];
    dateOfBirth = json['date_of_birth'];
    categoryName = json['category_name'];
    country = json['country'];
    countryFlag = json['country_flag'];
    major = json['major'].cast<String>();
  }
}
