import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class NotificationManager {
  static BuildContext? context;
  static dynamic init({required BuildContext context}) {
    context = context;
  }

  //this method used when notification come and app is closed or in background and
  // user click on it, i will left it empty for you
  static dynamic handleDataMsg(Map<String, dynamic> data) {}

  //this our method called when notification come and app is foreground
  static dynamic handleNotificationMsg(BuildContext context, Map<String?, String?> message) {
    logDebugMessage(message: "from mangger  $message");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.keys.first!),
      ),
    );
  }
}
