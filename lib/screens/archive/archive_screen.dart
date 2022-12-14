import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : ArchiveScreen
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.archive),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              "assets/images/archive.png",
              width: 150,
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
