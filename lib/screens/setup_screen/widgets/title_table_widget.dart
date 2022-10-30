import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleTableWidget extends StatelessWidget {
  const TitleTableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: CustomText(
          title: AppLocalizations.of(context)!.selectCountry,
          fontSize: 20,
          textColor: const Color(0xff034061),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
