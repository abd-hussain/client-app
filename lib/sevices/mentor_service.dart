import 'package:client_app/models/https/mentors_model.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class MentorService with Service {
  Future<MentorsModel> mentors(int categoryID) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentors,
      queryParam: {"categories_id": categoryID},
    );
    return MentorsModel.fromJson(response);
  }
}
