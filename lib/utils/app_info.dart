import 'dart:io';

import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/models/app_info_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  final myBox = Hive.box(DatabaseBoxConstant.userInfo);

  Future<AppinfoModel> get() async {
    final countryId = myBox.get(DatabaseFieldConstant.countryId);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String osVersion = "";
    String deviceTypeName = "";

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      osVersion = androidInfo.version.release!;
      deviceTypeName = androidInfo.model!;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      osVersion = iosInfo.systemVersion!;
      deviceTypeName = iosInfo.model!;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    var osType = "";

    if (Platform.isAndroid) {
      osType = "android";
    } else if (Platform.isIOS) {
      osType = "iOS";
    } else if (Platform.isMacOS) {
      osType = "MacOS";
    } else if (Platform.isWindows) {
      osType = "Windows";
    } else if (Platform.isLinux) {
      osType = "Linux";
    } else if (Platform.isFuchsia) {
      osType = "Fuchsia";
    }

    return AppinfoModel(
      countryId: int.parse(countryId),
      appVersion: packageInfo.version,
      osVersion: osVersion,
      deviceTypeName: deviceTypeName,
      osType: osType,
    );
  }
}
