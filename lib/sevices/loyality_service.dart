import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/models/https/loyality_rules.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';
import 'package:dio/dio.dart';

class LoyalityService with Service {
  Future<LoyalityRules> rules() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.loyalityRules,
    );
    return LoyalityRules.fromJson(response);
  }

  Future<AccountInfo> updatePoints({int points = 0}) async {
    FormData formData = FormData.fromMap({
      "points": MultipartFile.fromString(points.toString()),
    });
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.loyalityPoints,
      formData: formData,
    );
    return AccountInfo.fromJson(response);
  }
}
