import 'package:client_app/locator.dart';
import 'package:client_app/main_context.dart';
import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';

class NotificationManager {
  //this method used when notification come and app is closed or in background and
  // user click on it, i will left it empty for you
  static dynamic handleDataMsg(Map<String, dynamic> data) {}

  //this our method called when notification come and app is foreground
  static dynamic handleNotificationMsg(Map<String?, String?> message) {
    logDebugMessage(message: "from mangger  $message");

    ScaffoldMessenger.of(locator<MainContext>().mainContext!).showSnackBar(
      SnackBar(
        content: Text(message.keys.first!),
      ),
    );
  }
}
