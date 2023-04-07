import 'package:client_app/models/https/notifications_response.dart';
import 'package:client_app/sevices/noticitions_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationsBloc extends Bloc<NotificationsService> {
  final ValueNotifier<List<NotificationsResponseData>?> notificationsListNotifier =
      ValueNotifier<List<NotificationsResponseData>?>(null);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void listOfNotifications() {
    service.listOfNotifications().then((value) {
      notificationsListNotifier.value = value.data;
    });
  }

  void markNotificationReaded() async {
    await service.markAllNotificationsReaded();
  }

  void deleteNotification(int id) async {
    await service.deleteNotification(id);
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  @override
  onDispose() {
    notificationsListNotifier.dispose();
  }
}
