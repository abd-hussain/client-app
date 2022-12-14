import 'package:client_app/utils/mixins.dart';

class AnswersObj implements Model {
  List<AnswersList>? list;

  AnswersObj({this.list});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswersList {
  String question;
  String answer;
  int point;

  AnswersList({required this.question, required this.answer, required this.point});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['question'] = question;
    data['answer'] = answer;
    data['point'] = point;
    return data;
  }
}