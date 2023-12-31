import 'package:client_app/models/model_checker.dart';

class MentorInfoAvaliableResponse {
  MentorInfoAvaliableResponseData? data;
  String? message;

  MentorInfoAvaliableResponse({this.data, this.message});

  MentorInfoAvaliableResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? MentorInfoAvaliableResponseData.fromJson(json['data'])
        : null;
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
  String? bio;
  String? date;
  String? day;
  double? rate;
  int? hour;

  MentorInfoAvaliableResponseData({
    this.id,
    this.suffixeName,
    this.firstName,
    this.lastName,
    this.gender,
    this.profileImg,
    this.hourRate,
    this.bio,
    this.date,
    this.day,
    this.rate,
    this.hour,
  });

  MentorInfoAvaliableResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    profileImg = json['profile_img'];
    hourRate = convertToDouble(json['hour_rate']);
    bio = json['bio'];
    date = json['date'];
    day = json['day'];
    rate = convertToDouble(json['rate']);
    hour = json['hour'];
  }
}
