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
  double? hourRateByJD;
  String? profileImg;

  MentorsModelData({
    this.rate,
    this.id,
    this.categoryName,
    this.suffixeName,
    this.firstName,
    this.lastName,
    this.hourRateByJD,
    this.profileImg,
  });

  MentorsModelData.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    categoryName = json['category_name'];
    id = json['id'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    hourRateByJD = json['hour_rate_by_JD'];
    profileImg = json['profile_img'];
  }
}
