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
import 'package:google_mobile_ads/google_mobile_ads.dart';

//TODO: Rate Mentor when you finish call
//TODO: handle web
//TODO: fix ioS notifications
//TODO: Check Internet problem

void main() {
  runZonedGuarded(() async {
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
    if (error is DioException) {
      final exception = error.error;
      if (exception is HttpException) {
        debugPrint("MAIN");
        debugPrint(exception.status.toString());
        debugPrint(exception.message);
        debugPrint(exception.requestId);
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
