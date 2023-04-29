import 'dart:developer';

import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/push_notifications/notification_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FirebaseCloudMessagingUtil {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static dynamic initConfigure() async {
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        if (notification != null) {
          NotificationManager.handleNotificationMsg({message.notification!.title: message.notification!.body});
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        if (notification != null) {
          NotificationManager.handleNotificationMsg(message.data as Map<String?, String?>);
        }
      });

      _fcm.getToken().then((value) async {
        log('Token: $value');
        final box = Hive.box(DatabaseBoxConstant.userInfo);
        await box.put(DatabaseFieldConstant.pushNotificationToken, value);
      });
    }
  }
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
