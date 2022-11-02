import 'dart:async';

import 'package:client_app/locator.dart';
import 'package:client_app/myApp.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/errors/exceptions.dart';
import 'package:client_app/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  runZonedGuarded(() async {
    logDebugMessage(message: 'Application Started ...');
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();

    await Hive.initFlutter();
    // MobileAds.instance.initialize();
    await Hive.openBox(DatabaseBoxConstant.userInfo);

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    runApp(const MyApp());
  }, (error, stackTrace) {
    if (error is HttpException) {
      Logger().wtf(error.status);
      Logger().wtf(error.message);
      Logger().wtf(error.requestId);
    }
  });
}
