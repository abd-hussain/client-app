import 'package:client_app/locator.dart';
import 'package:client_app/myApp.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
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
}
