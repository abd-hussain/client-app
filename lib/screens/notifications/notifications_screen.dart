import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/sub_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Notifications"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SubPageHeaderName(title: AppLocalizations.of(context)!.notifications),
          //TODO : Handle Notifications
        ],
      ),
    );
  }
}
