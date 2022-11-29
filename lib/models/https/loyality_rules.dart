class LoyalityRules {
  List<LoyalityRulesData>? data;
  String? message;

  LoyalityRules({this.data, this.message});

  LoyalityRules.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LoyalityRulesData>[];
      json['data'].forEach((v) {
        data!.add(LoyalityRulesData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class LoyalityRulesData {
  int? id;
  String? content;
  int? points;
  String? action;
  String? createdAt;

  LoyalityRulesData({this.id, this.content, this.points, this.action, this.createdAt});

  LoyalityRulesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    points = json['points'];
    action = json['action'];
    createdAt = json['created_at'];
  }
}
