import 'dart:io';

import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/sevices/auth_services.dart';
import 'package:flutter/material.dart';

class LoginFourthStepBloc extends Bloc<AuthService> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  ValueNotifier<String> genderValue = ValueNotifier<String>("");

  TextEditingController referalCodeController = TextEditingController();
  DateTime dateOfbirth = DateTime.now();
  TextEditingController countryController = TextEditingController();
  File? profileImage;

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  void extractArguments(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      // countryCode = arguments[AppConstant.countryCode];
      // mobileNumber = arguments[AppConstant.mobileNumber];
      // apikey = arguments[AppConstant.apikey];
      // userId = arguments[AppConstant.userid];
    }
  }

  Future<void> callRequest() async {}
}
