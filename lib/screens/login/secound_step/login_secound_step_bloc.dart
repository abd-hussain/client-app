import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/models/https/auth_debug_response.dart';
import 'package:client_app/utils/sevices/auth_services.dart';
import 'package:flutter/material.dart';

class LoginSecoundStepBloc extends Bloc<AuthService> {
  String countryCode = "962";
  TextEditingController controller = TextEditingController();
  ValueNotifier<bool> enableVerifyBtn = ValueNotifier<bool>(false);
  List<String> countryCodeFiltered = [
    'YT',
    'YE',
    'US',
    'UA',
    'TR',
    'TN',
    'SY',
    'SH',
    'SE',
    'SD',
    'SC',
    'SA',
    'RU',
    'RO',
    'RE',
    'QA',
    'PT',
    'PS',
    'PM',
    'PK',
    'OM',
    'NZ',
    'MF',
    'MA',
    'LY',
    'LB',
    'KW',
    'KR',
    'JP',
    'JO',
    'IT',
    'IS',
    'IR',
    'IQ',
    'IL',
    'IE',
    'GR',
    'GP',
    'GB',
    'FR',
    'ES',
    'EG',
    'DZ',
    'DE',
    'CZ',
    'CN',
    'CI',
    'CA',
    'BR',
    'BH',
    'AR',
    'AE',
  ];

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
    if (controller.text[0] == "0") {
      controller.text = controller.text.substring(1);
    }
    return await service.auth(countryCode: countryCode, mobileNumber: controller.text);
  }
}
