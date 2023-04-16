class LoyalityPoint {
  LoyalityPointData? data;
  String? message;

  LoyalityPoint({this.data, this.message});

  LoyalityPoint.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? LoyalityPointData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class LoyalityPointData {
  int? id;
  int? points;

  LoyalityPointData({this.id, this.points});

  LoyalityPointData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
  }
}
