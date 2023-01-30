import 'package:client_app/screens/chat/chat_bloc.dart';
import 'package:client_app/screens/chat/widgets/list_chat_widget.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bloc = ChatBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Chat init Called ...');
    bloc.handleReadingArguments(context: context, arguments: ModalRoute.of(context)!.settings.arguments);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: ""),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ChatList(
                  chatListNotifier: bloc.chatListNotifier,
                ),
              ),
              Container(
                height: 70,
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: bloc.chatController,
                        hintText: AppLocalizations.of(context)!.message,
                        onChange: (text) {
                          if (text.isNotEmpty) {}
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        bloc.sendMessage();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Color(0xff444444),
                      ),
                    ),
                    const SizedBox(width: 8)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
