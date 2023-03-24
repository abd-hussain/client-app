import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventHeaderView extends StatelessWidget {
  const EventHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
        color: Colors.grey[200],
        width: MediaQuery.of(context).size.width,
        child: CustomText(
          title: AppLocalizations.of(context)!.comingevent,
          fontSize: 16,
          textColor: const Color(0xff444444),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
