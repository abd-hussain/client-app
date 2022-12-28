import 'package:client_app/models/https/mentor_details_model.dart';
import 'package:client_app/models/https/mentor_info_model.dart';
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

  Future<MentorDetailsResponse> getmentorDetails(int mentorID) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorDetails,
      queryParam: {"id": mentorID},
    );

    return MentorDetailsResponse.fromJson(response);
  }

  Future<MentorInfoResponse> getmentorAvaliablewithin60min({required int categoryID, required int hour}) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentoravaliable,
      queryParam: {"catId": categoryID, "after": hour},
    );
    print("response");
    print(response);

    return MentorInfoResponse.fromJson(response);
  }
}
