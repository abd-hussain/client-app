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
  void didChangeDependencies() {
    logDebugMessage(message: 'Notifications init Called ...');
    if (bloc.checkIfUserIsLoggedIn()) {
      bloc.markNotificationReaded();
      bloc.listOfNotifications();
    }
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
      appBar: customAppBar(title: AppLocalizations.of(context)!.notifications),
      body: NotificationsList(
        notificationsListNotifier: bloc.notificationsListNotifier,
        isUserIsLoggedIn: bloc.checkIfUserIsLoggedIn(),
        onDelete: (p0) {
          bloc.notificationsListNotifier.value!.remove(p0);
          bloc.deleteNotification(p0.id!);
        },
      ),
    );
  }
}
