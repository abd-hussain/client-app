import 'package:client_app/models/https/countries_model.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/auth_debug_response.dart';
import 'package:client_app/sevices/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:client_app/locator.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginSecoundStepBloc extends Bloc<AuthService> {
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  List<Country> countriesList = [];

  int countryId = 0;
  String countryCode = "";

  String mobileNumber = "";
  ValueNotifier<bool> enableVerifyBtn = ValueNotifier<bool>(false);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<AuthDebugResponse> callRequest() async {
    loadingStatus.value = LoadingStatus.inprogress;

    if (mobileNumber[0] == "0") {
      mobileNumber = mobileNumber.substring(1);
    }
    return await service.auth(
      countryId: countryId,
      countryCode: countryCode,
      mobileNumber: mobileNumber,
    );
  }

  void listOfCountries() {
    loadingStatus.value = LoadingStatus.inprogress;

    locator<FilterService>().countries().then((value) {
      countriesList = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      loadingStatus.value = LoadingStatus.finish;
    });
  }

  Country returnSelectedCountryFromDatabase() {
    countryId = int.parse(box.get(DatabaseFieldConstant.selectedCountryId));
    return Country(
        id: countryId,
        flagImage: box.get(DatabaseFieldConstant.selectedCountryFlag),
        name: box.get(DatabaseFieldConstant.selectedCountryName),
        currency: box.get(DatabaseFieldConstant.selectedCountryCurrency),
        dialCode: box.get(DatabaseFieldConstant.selectedCountryDialCode),
        maxLength:
            int.parse(box.get(DatabaseFieldConstant.selectedCountryMaxLenght)),
        minLength:
            int.parse(box.get(DatabaseFieldConstant.selectedCountryMinLenght)));
  }

  @override
  onDispose() {
    loadingStatus.dispose();
    enableVerifyBtn.dispose();
  }
}
