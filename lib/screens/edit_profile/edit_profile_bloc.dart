import 'dart:io';

import 'package:client_app/models/gender_model.dart';
import 'package:client_app/models/https/update_account_request.dart';
import 'package:client_app/sevices/account_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/gender_format.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileBloc extends Bloc<AccountService> {
  File? profileImage;
  String? profileImageUrl;
  String? selectedDate;
  String? _referalCode;
  List<Gender> listOfGenders = [];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  getAccountInformation(BuildContext context) {
    loadingStatus.value = LoadingStatus.inprogress;
    fillGenderList(context);
    service.getAccountInfo().then((value) {
      if (value.data != null) {
        firstNameController.text = value.data!.firstName ?? "";
        lastNameController.text = value.data!.lastName ?? "";
        if (value.data!.gender != null) {
          genderController.text = GenderFormat().convertIndexToString(context, value.data!.gender!);
        }
        emailController.text = value.data!.email ?? "";

        _referalCode = value.data!.referalCode;

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

  fillGenderList(BuildContext context) {
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
  }

  Future<bool> callRequest(BuildContext context) async {
    if (firstNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("First Name is Required"),
      ));
      return false;
    } else if (lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Last Name is Required"),
      ));
      return false;
    } else {
      loadingStatus.value = LoadingStatus.inprogress;
      await service.updateAccount(
        account: UpdateAccountRequest(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          referalCode: _referalCode,
          gender: GenderFormat().convertStringToIndex(context, genderController.text),
          countryId: int.parse(box.get(DatabaseFieldConstant.countryId)),
          dateOfBirth: selectedDate,
          profileImage: profileImage,
        ),
      );

      await box.put(DatabaseFieldConstant.userFirstName, firstNameController.text);
      return true;
    }
  }
}
