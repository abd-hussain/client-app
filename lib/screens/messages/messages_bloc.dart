import 'package:client_app/models/https/messages.dart';
import 'package:client_app/sevices/messages_services.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

class MessagesBloc extends Bloc<MessagesService> {
  final ValueNotifier<List<MessagesListData>?> messagesListNotifier = ValueNotifier<List<MessagesListData>?>(null);

  void listOfMessages() {
    service.listOfMessages().then((value) {
      if (value.data != null) {
        messagesListNotifier.value = value.data!;
      }
    });
  }

  @override
  onDispose() {
    messagesListNotifier.dispose();
  }
}
