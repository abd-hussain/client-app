import 'package:client_app/locator.dart';
import 'package:client_app/models/https/answers_obj.dart';
import 'package:client_app/models/https/answers_result_response.dart';
import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/models/https/mentors_model.dart';
import 'package:client_app/models/https/tips_questions.dart';
import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/sevices/tips_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TipsBloc extends Bloc<TipsService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  MainTips? tipInformations;
  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);
  List<AnswersList> answerslist = [];
  final ValueNotifier<List<MentorsModelData>?> mentorsListNotifier = ValueNotifier<List<MentorsModelData>?>([]);

  void handleReadingArguments({required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      tipInformations = newArguments["tip"] as MainTips;
    }
  }

  Future<TipsQuestionsModel> getQuestions() {
    return service.getTipQuestions(id: tipInformations!.id!);
  }

  Future<ResultOfTheTips> submitAnswers() async {
    final obj = AnswersObj(list: answerslist);
    return await service.submitAnswersAndGetResult(tipId: tipInformations!.id!, answersObj: obj);
  }

  void listOfMentors({required int categoryID}) {
    locator<MentorService>().mentors(categoryID).then((value) {
      if (value.data != null) {
        mentorsListNotifier.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      } else {
        mentorsListNotifier.value = [];
      }
    });
  }

  @override
  onDispose() {
    tipInformations = null;
    selectedIndexNotifier.dispose();
    mentorsListNotifier.dispose();
  }
}
