import 'package:client_app/models/https/answers_obj.dart';
import 'package:client_app/models/https/answers_result_response.dart';
import 'package:client_app/models/https/tips_questions.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class TipsService with Service {
  Future<TipsQuestionsModel> getTipQuestions({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.tipsQuestions,
      queryParam: {"tip_id": id},
    );
    return TipsQuestionsModel.fromJson(response);
  }

  Future<ResultOfTheTips> submitAnswersAndGetResult({required int tipId, required AnswersObj answersObj}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.tipsQuestions,
      queryParam: {"tip_id": tipId},
      postBody: answersObj,
    );
    return ResultOfTheTips.fromJson(response);
  }
}
