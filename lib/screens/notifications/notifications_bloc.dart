import 'package:client_app/models/https/notifications_response.dart';
import 'package:client_app/sevices/noticitions_services.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

class NotificationsBloc extends Bloc<NotificationsService> {
  final ValueNotifier<List<NotificationsResponseData>?> notificationsListNotifier =
      ValueNotifier<List<NotificationsResponseData>?>(null);

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
}
