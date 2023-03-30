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
  int? numberOfReviewr;

  MentorsModelData({
    this.rate,
    this.id,
    this.categoryName,
    this.suffixeName,
    this.firstName,
    this.lastName,
    this.hourRate,
    this.profileImg,
    this.languages,
    this.countryName,
    this.countryFlag,
    this.numberOfReviewr,
  });

  MentorsModelData.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    categoryName = json['category_name'];
    id = json['id'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    hourRate = json['hour_rate'];
    profileImg = json['profile_img'];
    languages = json['languages'].cast<String>();
    countryName = json['country_name'];
    countryFlag = AppConstant.imagesBaseURLForCountries + json['country_flag'];
    numberOfReviewr = json['number_of_reviewr'];
  }
}
