import 'package:client_app/models/https/chat.dart';
import 'package:client_app/models/https/chat_request.dart';
import 'package:client_app/sevices/messages_services.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

class ChatBloc extends Bloc<MessagesService> {
  final ValueNotifier<List<ChatListData>?> chatListNotifier = ValueNotifier<List<ChatListData>?>(null);
  TextEditingController chatController = TextEditingController();
  int messageId = 0;

  void handleReadingArguments({required BuildContext context, required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      messageId = newArguments["message_id"] as int;
      _callChatMessages(messageId);
    }
  }

  void _callChatMessages(int id) {
    service.listOfChats(id).then((value) {
      if (value.data != null) {
        chatListNotifier.value = value.data!;
      }
    });
  }

  void sendMessage() {
    if (chatController.text.isNotEmpty) {
      service.sendMessage(data: ChatRequest(messageId: messageId, message: chatController.text)).whenComplete(() {
        chatController.text = "";
        _callChatMessages(messageId);
      });
    }
  }

  @override
  onDispose() {
    chatListNotifier.dispose();
  }
}
