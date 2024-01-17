import 'package:client_app/utils/constants/constant.dart';

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
  int? id;
  String? categoryName;
  String? suffixeName;
  String? firstName;
  String? lastName;
  double? rate;
  double? hourRate;
  String? profileImg;
  List<String>? languages;
  String? countryName;
  String? countryFlag;
  String? currency;
  int? numberOfReviewers;

  MentorsModelData(
      {this.id,
      this.categoryName,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.rate,
      this.hourRate,
      this.profileImg,
      this.languages,
      this.countryName,
      this.countryFlag,
      this.currency,
      this.numberOfReviewers});

  MentorsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    rate = json['rate'];
    hourRate = json['hour_rate'];
    profileImg = AppConstant.imagesBaseURLForMentors + json['profile_img'];
    languages = json['languages'].cast<String>();
    countryName = json['country_name'];
    countryFlag = AppConstant.imagesBaseURLForCountries + json['country_flag'];
    currency = json['currency'];
    numberOfReviewers = json['number_of_reviewers'];
  }
}
