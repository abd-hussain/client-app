import 'package:client_app/screens/notifications/notifications_bloc.dart';
import 'package:client_app/screens/notifications/widgets/list_notification_widget.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var bloc = NotificationsBloc();

  @override
  void initState() {
    logDebugMessage(message: 'Notifications init Called ...');
    bloc.listOfNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.notifications),
      body: NotificationsList(
        notificationsListNotifier: bloc.notificationsListNotifier,
        onTap: (category) {
          //TODO
        },
      ),
    );
  }
}
