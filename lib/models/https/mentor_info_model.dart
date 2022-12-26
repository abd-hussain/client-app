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
  double? rate;
  String? profileImg;
  double? hourRateByJD;

  MentorInfoResponseData(
      {this.id, this.suffixeName, this.firstName, this.lastName, this.rate, this.profileImg, this.hourRateByJD});

  MentorInfoResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    rate = json['rate'];
    profileImg = json['profile_img'];
    hourRateByJD = json['hour_rate_by_JD'];
  }
}
