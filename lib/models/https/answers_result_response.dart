class ResultOfTheTips {
  ResultOfTheTipsData? data;
  String? message;

  ResultOfTheTips({this.data, this.message});

  ResultOfTheTips.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ResultOfTheTipsData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class ResultOfTheTipsData {
  int? id;
  int? tipsId;
  String? point;
  String? title;
  String? desc;

  ResultOfTheTipsData({this.id, this.tipsId, this.point, this.title, this.desc});

  ResultOfTheTipsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipsId = json['tips_id'];
    point = json['point'];
    title = json['title'];
    desc = json['desc'];
  }
}
