import 'dart:io';

import 'package:client_app/locator.dart';
import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/models/https/update_account_request.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/gender_format.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/countries_model.dart';
import 'package:client_app/sevices/account_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginFourthStepBloc extends Bloc<AccountService> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  Country? selectedCountry;
  TextEditingController genderController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  ValueNotifier<bool> enableReferalCode = ValueNotifier<bool>(true);
  ValueNotifier<bool?> validateReferalCode = ValueNotifier<bool?>(null);

  String? selectedDate;

  String profileImageUrl = "";
  File? profileImage;

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  List<Country> listOfCountries = [];
  int userId = 0;

  String argumentToken = "";
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void extractArguments(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      argumentToken = arguments[AppConstant.tokenToPass];
      userId = arguments[AppConstant.useridToPass];
    }
    _getListOfCountries();
    _getAccountInformation(context);
  }

  controllersHandler() {
    firstNameController.addListener(() => validateFields());
    lastNameController.addListener(() => validateFields());
  }

  validateFields() {
    if (firstNameController.text.isEmpty) {
      enableNextBtn.value = false;
    } else if (lastNameController.text.isEmpty) {
      enableNextBtn.value = false;
    } else if (validateReferalCode.value == false) {
      enableNextBtn.value = false;
    } else {
      enableNextBtn.value = true;
    }
    //Nothing is requierd
    loadingStatus.value = LoadingStatus.inprogress;
    loadingStatus.value = LoadingStatus.finish;
  }

  void _getListOfCountries() {
    locator<FilterService>().countries().then((value) {
      listOfCountries = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }

  void _getAccountInformation(BuildContext context) {
    box.put(DatabaseFieldConstant.token, argumentToken);

    service.getAccountInfo().then((value) {
      if (value.data != null) {
        firstNameController.text = value.data!.firstName ?? "";
        lastNameController.text = value.data!.lastName ?? "";
        if (value.data!.gender != null) {
          genderController.text =
              GenderFormat().convertIndexToString(context, value.data!.gender!);
        }
        emailController.text = value.data!.email ?? "";

        if (value.data!.countryId != null) {
          Iterable<Country> country = listOfCountries
              .where((element) => element.id! == value.data!.countryId!);
          countryController.text = country.first.name!;
          selectedCountry = country.first;
        }

        if (value.data!.dateOfBirth != null) {
          selectedDate = value.data!.dateOfBirth!;
        }

        if (value.data!.profileImg != null) {
          profileImageUrl = value.data!.profileImg!;
        }

        loadingStatus.value = LoadingStatus.finish;
      }
    });
  }

  Future<AccountInfo> callRequest(BuildContext context) async {
    loadingStatus.value = LoadingStatus.inprogress;

    return await service.updateAccount(
      account: UpdateAccountRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        referalCode: referalCodeController.text,
        gender:
            GenderFormat().convertStringToIndex(context, genderController.text),
        countryId: selectedCountry != null
            ? selectedCountry!.id!
            : int.parse(box.get(DatabaseFieldConstant.selectedCountryId)),
        dateOfBirth: selectedDate,
        profileImage: profileImage,
      ),
    );
  }

  void validateReferal(String code) {
    locator<FilterService>().validateReferalCode(code).then((value) {
      validateReferalCode.value = value;
    });
  }

  @override
  onDispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    countryController.dispose();
    genderController.dispose();
    referalCodeController.dispose();
    loadingStatus.dispose();
    enableReferalCode.dispose();
    enableNextBtn.dispose();
  }
}
