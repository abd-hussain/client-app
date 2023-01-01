import 'dart:async';

import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/auth_debug_response.dart';
import 'package:client_app/sevices/auth_services.dart';
import 'package:flutter/material.dart';

class LoginThirdStepBloc extends Bloc<AuthService> {
  final TextEditingController controller = TextEditingController();
  Timer? timer;
  int timerStartNumberSec = 59;
  int timerStartNumberMin = 2;

  String countryCode = "";
  ValueNotifier<bool> otpNotValid = ValueNotifier<bool>(false);

  String mobileNumber = "";
  int userId = 0;
  String apikey = "";

  void extractArguments(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      countryCode = arguments[AppConstant.countryCode];
      mobileNumber = arguments[AppConstant.mobileNumber];
      apikey = arguments[AppConstant.apikeyToPass];
      userId = arguments[AppConstant.useridToPass];
    }
  }

  void resetTimer() {
    timerStartNumberSec = 59;
    timerStartNumberMin = 2;
  }

  Future<VerifyOTPResponse> callVerifyRequset() async {
    return await service.verifyOTP(
        countryCode: countryCode, mobileNumber: mobileNumber, otp: controller.text, apiKey: apikey, userId: userId);
  }

  Future<AuthDebugResponse> callRequest() async {
    return await service.auth(countryCode: countryCode, mobileNumber: controller.text);
  }

  @override
  onDispose() {
    controller.dispose();
    timer!.cancel();
    otpNotValid.dispose();
  }
}
