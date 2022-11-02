import 'package:client_app/utils/app_info.dart';
import 'package:client_app/utils/models/app_info_model.dart';
import 'package:client_app/utils/models/https/auth_debug_request.dart';
import 'package:client_app/utils/models/https/auth_debug_response.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class AuthService {
  Future<AuthDebugResponse> auth({required String countryCode, required String mobileNumber}) async {
    AppinfoModel appInfo = await AppInfo().get();

    final body = AuthDebugRequest(
        mobileNumber: "00$countryCode$mobileNumber",
        osType: appInfo.osType,
        deviceTypeName: appInfo.deviceTypeName,
        osVersion: appInfo.osVersion,
        appVersion: appInfo.appVersion,
        countryId: appInfo.countryId);

    final response = await HttpRepository()
        .callRequest(requestType: RequestType.post, methodName: MethodNameConstant.authDebuging, postBody: body);

    return AuthDebugResponse.fromJson(response);
  }

  Future<VerifyOTPresponse> verifyOTP(
      {required String countryCode,
      required String mobileNumber,
      required String otp,
      required String apiKey,
      required int userId}) async {
    AppinfoModel appInfo = await AppInfo().get();

    final body = VerifyOTPrequest(
        mobileNumber: "00$countryCode$mobileNumber",
        osType: appInfo.osType,
        deviceTypeName: appInfo.deviceTypeName,
        osVersion: appInfo.osVersion,
        appVersion: appInfo.appVersion,
        countryId: appInfo.countryId,
        otp: otp,
        apiKey: apiKey,
        userId: userId);

    try {
      final response = await HttpRepository()
          .callRequest(requestType: RequestType.post, methodName: MethodNameConstant.authVerify, postBody: body);
      return VerifyOTPresponse.fromJson(response);
    } catch (error) {
      return VerifyOTPresponse();
    }
  }
}
