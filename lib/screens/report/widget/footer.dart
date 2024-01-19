import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportFooterView extends StatelessWidget {
  const ReportFooterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: CustomText(
          title: AppLocalizations.of(context)!.reportFooterText,
          fontSize: 10,
          maxLins: 2,
          textAlign: TextAlign.center,
          textColor: const Color(0xffBFBFBF),
        ),
      ),
    );
  }
}
