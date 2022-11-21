import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : MessagesScreen
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.messages),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(child: Container()),
            const Center(
              child: Text("MessagesScreen"),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
