import 'dart:developer';
import 'dart:io';

import 'package:client_app/my_app.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/push_notifications/notification_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FirebaseCloudMessagingUtil {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static dynamic initConfigure(BuildContext context) async {
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //  _iosPermission();
    if (Platform.isIOS) {
      _fcm.requestPermission(sound: true, badge: true, alert: true);
    }
    // _fcm.requestNotificationPermissions();
    _fcm.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        return NotificationManager.handleNotificationMsg(
            buildContext!, {message.notification!.title: message.notification!.body});
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        return NotificationManager.handleNotificationMsg(buildContext!, message.data as Map<String?, String?>);
      }
    });

    _fcm.getToken().then((value) async {
      log('Token: $value');
      final box = Hive.box(DatabaseBoxConstant.userInfo);
      await box.put(DatabaseFieldConstant.pushNotificationToken, value);
    });
  }
}
