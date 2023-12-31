import 'dart:async';
import 'package:client_app/locator.dart';
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
import 'package:logger/logger.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//TODO: handle Timing UTC
//TODO: Rate Mentor when you finish call
//TODO: User should add majors and note before resrve call

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    logDebugMessage(message: 'Application Started ...');
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox(DatabaseBoxConstant.userInfo);

    await setupLocator();

    if (!kIsWeb) {
      await MobileAds.instance.initialize();
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
            testDeviceIds: ['FA1E4A4C91519CDE5813ABB70A84651E']),
      );
      await _setupFirebase();
    }

    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
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

Future<bool> _setupFirebase() async {
  NetworkInfoService networkInfoService = NetworkInfoService();
  bool hasConnectivity;
  hasConnectivity = await networkInfoService.checkConnectivityonLunching();

  if (hasConnectivity) {
    await Firebase.initializeApp();
  } else {
    networkInfoService.firebaseInitNetworkStateStreamControler.stream
        .listen((event) async {
      if (event && Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
    });
  }
  networkInfoService.initNetworkConnectionCheck();

  return hasConnectivity;
}
