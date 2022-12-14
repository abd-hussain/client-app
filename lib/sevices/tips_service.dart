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
}
