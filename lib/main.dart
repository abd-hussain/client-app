import 'dart:async';
import 'package:client_app/locator.dart';
import 'package:client_app/my_app.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/errors/exceptions.dart';
import 'package:client_app/utils/logger.dart';
import 'package:dio/dio.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//TODO: handle Timing UTC

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    logDebugMessage(message: 'Application Started ...');
    WidgetsFlutterBinding.ensureInitialized();

    // await Firebase.initializeApp();

    // FlutterError.onError = (errorDetails) async {
    //   await FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    // };

    // PlatformDispatcher.instance.onError = (error, stack) {
    //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //   return true;
    // };

    await Hive.initFlutter();
    await Hive.openBox(DatabaseBoxConstant.userInfo);

    await MobileAds.instance.initialize();
    // thing to add
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['FA1E4A4C91519CDE5813ABB70A84651E']),
    );

    await setupLocator();
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    runApp(const MyApp());
  }, (error, stackTrace) {
    if (error is DioError) {
      final exception = error.error;
      if (exception is HttpException) {
        Logger().wtf(exception.status);
        Logger().wtf(exception.message);
      }
    }
  });
}
