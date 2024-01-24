import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CallAboutView extends StatelessWidget {
  final String? majorName;
  const CallAboutView({super.key, this.majorName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 16, left: 16, bottom: 8),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              title: AppLocalizations.of(context)!.callabout,
              fontSize: 12,
              textColor: const Color(0xff554d56),
            ),
            CustomText(
              title: majorName ?? "",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff554d56),
            ),
          ],
        ),
      ),
    );
  }
}
