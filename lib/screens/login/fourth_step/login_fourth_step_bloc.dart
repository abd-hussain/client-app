import 'dart:async';
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
import 'package:client_app/models/gender_model.dart';
import 'package:client_app/models/https/countries_model.dart';
import 'package:client_app/sevices/account_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginFourthStepBloc extends Bloc<AccountService> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  Country? selectedCountry;
  TextEditingController genderController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  ValueNotifier<bool> enableReferalCode = ValueNotifier<bool>(true);

  String? selectedDate;

  File? profileImage;
  String? profileImageUrl;

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  List<Country> listOfCountries = [];
  List<Gender> listOfGenders = [];
  int userId = 0;

  String argumentToken = "";
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void extractArguments(BuildContext context) {
    listOfGenders = [
      Gender(
          name: AppLocalizations.of(context)!.gendermale,
          icon: const Icon(
            Icons.male,
            color: Color(0xff444444),
          )),
      Gender(name: AppLocalizations.of(context)!.genderfemale, icon: const Icon(Icons.female)),
      Gender(name: AppLocalizations.of(context)!.genderother, icon: const Icon(Icons.align_horizontal_center))
    ];

    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      argumentToken = arguments[AppConstant.tokenToPass];
      userId = arguments[AppConstant.useridToPass];
    }

    getAccountInformation(context);
    getListOfCountries();
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
    } else {
      enableNextBtn.value = true;
    }
    //Nothing is requierd
    loadingStatus.value = LoadingStatus.inprogress;

    loadingStatus.value = LoadingStatus.finish;
  }

  void getListOfCountries() {
    locator<FilterService>().countries().then((value) {
      listOfCountries = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }

  getAccountInformation(BuildContext context) {
    box.put(DatabaseFieldConstant.token, argumentToken);

    AccountService().getAccountInfo().then((value) {
      if (value.data != null) {
        firstNameController.text = value.data!.firstName ?? "";
        lastNameController.text = value.data!.lastName ?? "";
        if (value.data!.gender != null) {
          genderController.text = GenderFormat().convertIndexToString(context, value.data!.gender!);
        }
        emailController.text = value.data!.email ?? "";

        if (value.data!.referalCode != null) {
          enableReferalCode.value = false;
          referalCodeController.text = value.data!.referalCode!;
        }

        if (value.data!.countryId != null) {
          Iterable<Country> country = listOfCountries.where((element) => element.id! == value.data!.countryId!);
          countryController.text = country.first.name!;
          selectedCountry = country.first;
        }

        if (value.data!.dateOfBirth != null) {
          selectedDate = value.data!.dateOfBirth!;
        }

        if (value.data!.profileImg != null) {
          profileImageUrl = value.data!.profileImg;
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
        gender: GenderFormat().convertStringToIndex(context, genderController.text),
        countryId: selectedCountry != null ? selectedCountry!.id! : int.parse(box.get(DatabaseFieldConstant.countryId)),
        dateOfBirth: selectedDate,
        profileImage: profileImage,
      ),
    );
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

    throw UnimplementedError();
  }
}
