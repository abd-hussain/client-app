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
  double? hourRateByJD;
  double? totalRate;
  int? gender;
  String? profileImg;
  String? dateOfBirth;
  String? categoryName;
  String? country;
  String? countryFlag;
  List<String>? major;
  List<int>? workingHoursSaturday;
  List<int>? workingHoursSunday;
  List<int>? workingHoursMonday;
  List<int>? workingHoursTuesday;
  List<int>? workingHoursWednesday;
  List<int>? workingHoursThursday;
  List<int>? workingHoursFriday;
  List<Reviews>? reviews;

  MentorDetailsResponseData(
      {this.suffixeName,
      this.firstName,
      this.lastName,
      this.bio,
      this.speakingLanguage,
      this.hourRateByJD,
      this.totalRate,
      this.gender,
      this.profileImg,
      this.dateOfBirth,
      this.categoryName,
      this.country,
      this.countryFlag,
      this.major,
      this.workingHoursSaturday,
      this.workingHoursSunday,
      this.workingHoursMonday,
      this.workingHoursTuesday,
      this.workingHoursWednesday,
      this.workingHoursThursday,
      this.workingHoursFriday,
      this.reviews});

  MentorDetailsResponseData.fromJson(Map<String, dynamic> json) {
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    bio = json['bio'];
    speakingLanguage = json['speaking_language'].cast<String>();
    hourRateByJD = json['hour_rate'];
    totalRate = json['total_rate'];
    gender = json['gender'];
    profileImg = json['profile_img'];
    dateOfBirth = json['date_of_birth'];
    categoryName = json['category_name'];
    country = json['country'];
    countryFlag = json['country_flag'];
    major = json['major'].cast<String>();
    workingHoursSaturday = json['working_hours_saturday'].cast<int>();
    workingHoursSunday = json['working_hours_sunday'].cast<int>();
    workingHoursMonday = json['working_hours_monday'].cast<int>();
    workingHoursTuesday = json['working_hours_tuesday'].cast<int>();
    workingHoursWednesday = json['working_hours_wednesday'].cast<int>();
    workingHoursThursday = json['working_hours_thursday'].cast<int>();
    workingHoursFriday = json['working_hours_friday'].cast<int>();
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }
}

class Reviews {
  int? id;
  String? clientFirstName;
  String? clientLastName;
  String? clientProfileImg;
  int? mentorId;
  double? stars;
  String? comments;
  String? createdAt;

  Reviews(
      {this.id,
      this.clientFirstName,
      this.clientLastName,
      this.clientProfileImg,
      this.mentorId,
      this.stars,
      this.comments,
      this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientFirstName = json['client_first_name'];
    clientLastName = json['client_last_name'];
    clientProfileImg = json['client_profile_img'];
    mentorId = json['mentor_id'];
    stars = json['stars'];
    comments = json['comments'];
    createdAt = json['created_at'];
  }
}
