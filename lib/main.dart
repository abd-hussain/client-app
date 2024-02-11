import 'dart:async';
import 'package:client_app/locator.dart';
import 'package:client_app/main_context.dart';
import 'package:client_app/my_app.dart';
import 'package:client_app/sevices/general/network_info_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/errors/exceptions.dart';
import 'package:client_app/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO: Rate Mentor when you finish call
//TODO: handle web
//TODO: fix ioS notifications

void main() {
  runZonedGuarded(() async {
    logDebugMessage(message: 'Application Started ...');
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox(DatabaseBoxConstant.userInfo);
    bool hasConnectivity = await _initInternetConnection();
    await setupLocator();

    if (!kIsWeb) {
      await _setupFirebase(hasConnectivity);

      await MobileAds.instance.initialize();
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
            testDeviceIds: ['FA1E4A4C91519CDE5813ABB70A84651E']),
      );
    }

    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    runApp(
      MyApp(isConnected: hasConnectivity),
    );
  }, (error, stackTrace) {
    if (error is DioException) {
      final exception = error.error;
      if (exception is HttpException) {
        debugPrint("MAIN");
        debugPrint(exception.status.toString());
        debugPrint(exception.message);
        debugPrint(exception.requestId);
      }
    } else if (error is ConnectionException) {
      ScaffoldMessenger.of(locator<MainContext>().mainContext!).showSnackBar(
        SnackBar(
          content: Text(
              AppLocalizations.of(locator<MainContext>().mainContext!)!
                  .nointernetconnection),
        ),
      );
    }
  });
}

Future<bool> _initInternetConnection() async {
  NetworkInfoService networkInfoService = NetworkInfoService();
  networkInfoService.initNetworkConnectionCheck();
  return await networkInfoService.checkConnectivityonLunching();
}

_setupFirebase(bool hasConnectivity) async {
  if (hasConnectivity) {
    await Firebase.initializeApp();
  }
}
