import 'package:client_app/models/https/loyality_point_request.dart';
import 'package:client_app/models/https/loyality_point_response.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class LoyalityService with Service {
  Future<LoyalityPoint> getProfilePoints() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.loyality,
    );
    return LoyalityPoint.fromJson(response);
  }

  Future<dynamic> requestToAddPoint({required LoyalityPointRequest body}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.loyality,
      postBody: body,
    );
    return response;
  }
}
