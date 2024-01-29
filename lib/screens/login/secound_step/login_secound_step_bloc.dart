import 'package:client_app/models/https/countries_model.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/errors/exceptions.dart';
import 'package:client_app/utils/logger.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/sevices/auth_services.dart';
import 'package:client_app/utils/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:client_app/locator.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginSecoundStepBloc extends Bloc<AuthService> {
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<String> errorMessage = ValueNotifier<String>("");
  List<Country> countriesList = [];
  BuildContext? maincontext;

  int countryId = 0;
  String countryCode = "";

  String mobileNumber = "";
  ValueNotifier<bool> enableVerifyBtn = ValueNotifier<bool>(false);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<void> callRequest({required BuildContext context}) async {
    loadingStatus.value = LoadingStatus.inprogress;

    if (mobileNumber[0] == "0") {
      mobileNumber = mobileNumber.substring(1);
    }

    try {
      final info = await service.auth(
        countryId: countryId,
        countryCode: countryCode,
        mobileNumber: mobileNumber,
      );
      loadingStatus.value = LoadingStatus.finish;
      logger.wtf(info.data!.lastOtp);

      _openMainScreen(id: info.data!.id!, apiKey: info.data!.apiKey!);
    } on DioException catch (e) {
      loadingStatus.value = LoadingStatus.finish;
      final error = e.error as HttpException;
      if (error.message.toString() == "User Blocked") {
        errorMessage.value = AppLocalizations.of(maincontext!)!.userblocked;
      } else {
        errorMessage.value = error.message.toString();
      }
    }
  }

  void _openMainScreen({required int id, required String apiKey}) async {
    final navigator = Navigator.of(maincontext!, rootNavigator: true);

    await navigator.pushNamed(RoutesConstants.loginThirdStepRoute, arguments: {
      AppConstant.countryId: countryId,
      AppConstant.countryCode: countryCode,
      AppConstant.mobileNumber: mobileNumber,
      AppConstant.useridToPass: id,
      AppConstant.apikeyToPass: apiKey
    });
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
        countryCode: box.get(DatabaseFieldConstant.selectedCountryCode),
        currencyCode: box.get(DatabaseFieldConstant.selectedCurrencyCode),
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
