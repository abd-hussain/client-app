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
  double? rate;
  int? countryId;
  String? dateOfBirth;
  int? id;
  String? categoryName;
  String? suffixeName;
  int? gender;
  String? firstName;
  String? lastName;
  int? classMin;
  double? hourRateByJD;
  String? profileImg;

  MentorsModelData({
    this.rate,
    this.countryId,
    this.dateOfBirth,
    this.id,
    this.categoryName,
    this.suffixeName,
    this.gender,
    this.firstName,
    this.lastName,
    this.classMin,
    this.hourRateByJD,
    this.profileImg,
  });

  MentorsModelData.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    categoryName = json['category_name'];
    dateOfBirth = json['date_of_birth'];
    id = json['id'];
    suffixeName = json['suffixe_name'];
    gender = json['gender'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryId = json['country_id'];
    classMin = json['class_min'];
    hourRateByJD = json['hour_rate_by_JD'];
    profileImg = json['profile_img'];
  }
}
