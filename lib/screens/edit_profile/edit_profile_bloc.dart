import 'dart:io';

import 'package:client_app/locator.dart';
import 'package:client_app/models/gender_model.dart';
import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/models/https/countries_model.dart';
import 'package:client_app/models/https/update_account_request.dart';
import 'package:client_app/sevices/account_service.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/gender_format.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileBloc extends Bloc<AccountService> {
  String profileImageUrl = "";
  File? profileImage;
  String? selectedDate;
  List<Gender> listOfGenders = [];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();

  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  final box = Hive.box(DatabaseBoxConstant.userInfo);
  List<Country> listOfCountries = [];
  Country? selectedCountry;

  getAccountInformation(BuildContext context) async {
    loadingStatus.value = LoadingStatus.inprogress;
    _fillGenderList(context);
    await _getListOfCountries();

    service.getAccountInfo().then((value) {
      if (value.data != null) {
        firstNameController.text = value.data!.firstName ?? "";
        lastNameController.text = value.data!.lastName ?? "";
        emailController.text = value.data!.email ?? "";
        mobileNumberController.text = value.data!.mobileNumber ?? "";
        referalCodeController.text = value.data!.invitationCode ?? "";

        if (value.data!.gender != null) {
          genderController.text =
              GenderFormat().convertIndexToString(context, value.data!.gender!);
        }

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

  void _fillGenderList(BuildContext context) {
    listOfGenders = [
      Gender(
          name: AppLocalizations.of(context)!.gendermale,
          icon: const Icon(
            Icons.male,
            color: Color(0xff444444),
          )),
      Gender(
          name: AppLocalizations.of(context)!.genderfemale,
          icon: const Icon(Icons.female)),
      Gender(
          name: AppLocalizations.of(context)!.genderother,
          icon: const Icon(Icons.align_horizontal_center))
    ];
  }

  Future<void> _getListOfCountries() async {
    await locator<FilterService>().countries().then((value) {
      listOfCountries = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }

  Future<AccountInfo?> callRequest(BuildContext context) async {
    if (firstNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.firstnamerequired),
      ));
      return null;
    } else if (lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.lastnamerequired),
      ));
      return null;
    } else {
      loadingStatus.value = LoadingStatus.inprogress;

      final body = UpdateAccountRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        gender:
            GenderFormat().convertStringToIndex(context, genderController.text),
        countryId: selectedCountry != null
            ? selectedCountry!.id!
            : int.parse(box.get(DatabaseFieldConstant.selectedCountryId)),
        dateOfBirth: selectedDate,
        profileImage: profileImage,
      );

      return await service.updateAccount(account: body);
    }
  }

  @override
  onDispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    loadingStatus.dispose();
  }
}
