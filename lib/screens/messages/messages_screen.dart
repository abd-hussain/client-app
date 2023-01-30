import 'package:client_app/screens/messages/messages_bloc.dart';
import 'package:client_app/screens/messages/widgets/list_messages_widget.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/utils/logger.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final bloc = MessagesBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Messages init Called ...');
    bloc.listOfMessages();
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
      appBar: customAppBar(title: AppLocalizations.of(context)!.messages),
      body: SafeArea(
        child: MessagesList(
          messagesListNotifier: bloc.messagesListNotifier,
          onOpen: (item) {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.chatScreen, arguments: {"message_id": item.id});
          },
        ),
      ),
    );
  }
}
