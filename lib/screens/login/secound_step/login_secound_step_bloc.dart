import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/auth_debug_response.dart';
import 'package:client_app/sevices/auth_services.dart';
import 'package:flutter/material.dart';

class LoginSecoundStepBloc extends Bloc<AuthService> {
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  String countryCode = "962";
  TextEditingController controller = TextEditingController();
  ValueNotifier<bool> enableVerifyBtn = ValueNotifier<bool>(false);

  controllerLisiner() {
    controller.addListener(() {
      _verifyMobileNumberValidation();
    });
  }

  void _verifyMobileNumberValidation() {
    enableVerifyBtn.value = false;

    if (controller.text.length >= 9) {
      enableVerifyBtn.value = true;
    }
  }

  Future<AuthDebugResponse> callRequest() async {
    loadingStatus.value = LoadingStatus.inprogress;

    if (controller.text[0] == "0") {
      controller.text = controller.text.substring(1);
    }
    return await service.auth(countryCode: countryCode, mobileNumber: controller.text);
  }

  @override
  onDispose() {
    loadingStatus.dispose();
    controller.dispose();
    enableVerifyBtn.dispose();
  }
}
