import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/models/https/tips_questions.dart';
import 'package:client_app/sevices/tips_service.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

class TipsBloc extends Bloc<TipsService> {
  MainTips? tipInformations;
  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  void handleReadingArguments({required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      tipInformations = newArguments["tip"] as MainTips;
    }
  }

  Future<TipsQuestionsModel> getQuestions() {
    return service.getTipQuestions(id: tipInformations!.id!);
  }

  @override
  onDispose() {
    tipInformations = null;
    selectedIndexNotifier.dispose();
  }
}
