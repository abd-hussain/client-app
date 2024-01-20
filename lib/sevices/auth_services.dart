import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/auth_request.dart';
import 'package:client_app/models/https/auth_response.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';
import 'package:client_app/utils/version.dart';

class AuthService with Service {
  Future<AuthResponse> auth(
      {required int countryId,
      required String countryCode,
      required String mobileNumber}) async {
    String? version = await Version().getApplicationVersion();

    final body = AuthRequest(
        mobileNumber: "$countryCode$mobileNumber",
        appVersion: version,
        countryId: countryId);

    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.auth,
      postBody: body,
    );

    return AuthResponse.fromJson(response);
  }

  Future<VerifyOTPResponse> verifyOTP(
      {required String countryCode,
      required String mobileNumber,
      required String otp,
      required String apiKey,
      required int userId}) async {
    final body = VerifyOTPrequest(
      mobileNumber: "$countryCode$mobileNumber",
      otp: otp,
      apiKey: apiKey,
      userId: userId,
    );

    final response = await repository.callRequest(
        requestType: RequestType.post,
        methodName: MethodNameConstant.authVerify,
        postBody: body);
    return VerifyOTPResponse.fromJson(response);
  }
}
