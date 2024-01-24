import 'package:client_app/models/model_checker.dart';

class MentorDetailsResponse {
  MentorDetailsResponseData? data;
  String? message;

  MentorDetailsResponse({this.data, this.message});

  MentorDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? MentorDetailsResponseData.fromJson(json['data'])
        : null;
    message = json['message'];
  }
}

class MentorDetailsResponseData with ModelChecker {
  int? id;
  String? suffixeName;
  String? firstName;
  String? lastName;
  String? bio;
  List<String>? speakingLanguage;
  double? hourRate;
  int? freeCall;
  String? currency;
  double? totalRate;
  int? gender;
  String? profileImg;
  String? dateOfBirth;
  String? experienceSince;
  String? categoryName;
  int? categoryID;
  String? country;
  String? countryFlag;
  List<Major>? majors;
  List<int>? workingHoursSaturday;
  List<int>? workingHoursSunday;
  List<int>? workingHoursMonday;
  List<int>? workingHoursTuesday;
  List<int>? workingHoursWednesday;
  List<int>? workingHoursThursday;
  List<int>? workingHoursFriday;
  List<Reviews>? reviews;

  MentorDetailsResponseData(
      {this.id,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.bio,
      this.speakingLanguage,
      this.hourRate,
      this.freeCall,
      this.currency,
      this.totalRate,
      this.gender,
      this.profileImg,
      this.dateOfBirth,
      this.experienceSince,
      this.categoryName,
      this.categoryID,
      this.country,
      this.countryFlag,
      this.majors,
      this.workingHoursSaturday,
      this.workingHoursSunday,
      this.workingHoursMonday,
      this.workingHoursTuesday,
      this.workingHoursWednesday,
      this.workingHoursThursday,
      this.workingHoursFriday,
      this.reviews});

  MentorDetailsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suffixeName = convertToString(json['suffixe_name']);
    firstName = convertToString(json['first_name']);
    lastName = convertToString(json['last_name']);
    bio = convertToString(json['bio']);
    speakingLanguage = json['speaking_language'].cast<String>();
    hourRate = convertToDouble(json['hour_rate']);
    freeCall = json['free_call'];
    currency = convertToString(json['currency']);
    totalRate = convertToDouble(json['total_rate']);
    gender = json['gender'];
    profileImg = convertToString(json['profile_img']);
    dateOfBirth = convertToString(json['date_of_birth']);
    experienceSince = convertToString(json['experience_since']);
    categoryName = convertToString(json['category_name']);
    categoryID = json['category_id'];
    country = convertToString(json['country']);
    countryFlag = convertToString(json['country_flag']);
    if (json['major'] != null) {
      majors = <Major>[];
      json['major'].forEach((v) {
        majors!.add(Major.fromJson(v));
      });
    }
    workingHoursSaturday = json['working_hours_saturday'].cast<int>();
    workingHoursSunday = json['working_hours_sunday'].cast<int>();
    workingHoursMonday = json['working_hours_monday'].cast<int>();
    workingHoursTuesday = json['working_hours_tuesday'].cast<int>();
    workingHoursWednesday = json['working_hours_wednesday'].cast<int>();
    workingHoursThursday = json['working_hours_thursday'].cast<int>();
    workingHoursFriday = json['working_hours_friday'].cast<int>();
    reviews = <Reviews>[];
    json['reviews'].forEach((v) {
      reviews!.add(Reviews.fromJson(v));
    });
  }
}

class Major {
  int? id;
  String? name;

  Major({this.id, this.name});

  Major.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Reviews with ModelChecker {
  int? id;
  String? clientFirstName;
  String? clientLastName;
  String? clientProfileImg;
  int? mentorId;
  double? stars;
  String? comments;
  String? mentorResponse;
  String? flagImage;
  String? createdAt;

  Reviews(
      {this.id,
      this.clientFirstName,
      this.clientLastName,
      this.clientProfileImg,
      this.mentorId,
      this.stars,
      this.comments,
      this.mentorResponse,
      this.flagImage,
      this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientFirstName = convertToString(json['client_first_name']);
    clientLastName = convertToString(json['client_last_name']);
    clientProfileImg = convertToString(json['client_profile_img']);
    mentorId = json['mentor_id'];
    stars = convertToDouble(json['stars']);
    comments = convertToString(json['comments']);
    mentorResponse = convertToString(json['mentor_response']);
    flagImage = convertToString(json['flag_image']);
    createdAt = convertToString(json['created_at']);
  }
}
