import 'package:client_app/models/model_checker.dart';

class MentorInfoAvaliableResponse {
  List<MentorInfoAvaliableResponseData>? data;
  String? message;

  MentorInfoAvaliableResponse({this.data, this.message});

  MentorInfoAvaliableResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MentorInfoAvaliableResponseData>[];
      json['data'].forEach((v) {
        data!.add(MentorInfoAvaliableResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class MentorInfoAvaliableResponseData with ModelChecker {
  int? id;
  String? suffixeName;
  String? firstName;
  String? lastName;
  int? gender;
  String? profileImg;
  double? hourRate;
  List<int>? workingHours;
  double? rate;
  String? date;
  String? currency;
  String? currencyCode;
  String? countryCode;
  List<String>? languages;
  String? countryName;
  String? countryFlag;
  int? numberOfReviewers;
  String? day;
  int? hour;

  MentorInfoAvaliableResponseData(
      {this.id,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.gender,
      this.profileImg,
      this.hourRate,
      this.workingHours,
      this.rate,
      this.date,
      this.currency,
      this.countryCode,
      this.currencyCode,
      this.languages,
      this.countryName,
      this.countryFlag,
      this.numberOfReviewers,
      this.day,
      this.hour});

  MentorInfoAvaliableResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    profileImg = json['profile_img'];
    hourRate = convertToDouble(json['hour_rate']);
    workingHours = json['working_hours'].cast<int>();
    rate = convertToDouble(json['rate']);
    date = json['date'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    countryCode = json['country_code'];
    languages = json['languages'].cast<String>();
    countryName = json['country_name'];
    countryFlag = json['country_flag'];
    numberOfReviewers = json['number_of_reviewers'];
    day = json['day'];
    hour = json['hour'];
  }
}
