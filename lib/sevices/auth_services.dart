import 'package:client_app/utils/app_info.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/app_info_model.dart';
import 'package:client_app/models/https/auth_debug_request.dart';
import 'package:client_app/models/https/auth_debug_response.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class AuthService with Service {
  Future<AuthDebugResponse> auth({required String countryCode, required String mobileNumber}) async {
    AppinfoModel appInfo = await AppInfo().get();

    final body = AuthDebugRequest(
        mobileNumber: "$countryCode$mobileNumber",
        osType: appInfo.osType,
        deviceTypeName: appInfo.deviceTypeName,
        osVersion: appInfo.osVersion,
        appVersion: appInfo.appVersion,
        countryId: appInfo.countryId);

    final response = await repository.callRequest(
        requestType: RequestType.post, methodName: MethodNameConstant.authDebuging, postBody: body);

    return AuthDebugResponse.fromJson(response);
  }

  Future<VerifyOTPResponse> verifyOTP(
      {required String countryCode,
      required String mobileNumber,
      required String otp,
      required String apiKey,
      required int userId}) async {
    AppinfoModel appInfo = await AppInfo().get();

    final body = VerifyOTPrequest(
        mobileNumber: "$countryCode$mobileNumber",
        osType: appInfo.osType,
        deviceTypeName: appInfo.deviceTypeName,
        osVersion: appInfo.osVersion,
        appVersion: appInfo.appVersion,
        countryId: appInfo.countryId,
        otp: otp,
        apiKey: apiKey,
        userId: userId);

    try {
      final response = await repository.callRequest(
          requestType: RequestType.post, methodName: MethodNameConstant.authVerify, postBody: body);
      return VerifyOTPResponse.fromJson(response);
    } catch (error) {
      return VerifyOTPResponse();
    }
  }
}
