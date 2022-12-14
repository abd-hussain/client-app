class TipsQuestionsModel {
  List<TipsQuestionsModelData>? data;
  String? message;

  TipsQuestionsModel({this.data, this.message});

  TipsQuestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TipsQuestionsModelData>[];
      json['data'].forEach((v) {
        data!.add(TipsQuestionsModelData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class TipsQuestionsModelData {
  int? id;
  String? question;
  String? answer1;
  int? answer1Points;
  String? answer2;
  int? answer2Points;
  String? answer3;
  int? answer3Points;
  String? answer4;
  int? answer4Points;

  TipsQuestionsModelData(
      {this.id,
      this.question,
      this.answer1,
      this.answer1Points,
      this.answer2,
      this.answer2Points,
      this.answer3,
      this.answer3Points,
      this.answer4,
      this.answer4Points});

  TipsQuestionsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer1 = json['answer1'];
    answer1Points = json['answer1_points'];
    answer2 = json['answer2'];
    answer2Points = json['answer2_points'];
    answer3 = json['answer3'];
    answer3Points = json['answer3_points'];
    answer4 = json['answer4'];
    answer4Points = json['answer4_points'];
  }
}
