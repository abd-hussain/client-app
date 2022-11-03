import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderView extends StatelessWidget {
  final String selectedGenderValue;
  final Function(String gender) selectedGender;

  const GenderView({required this.selectedGender, required this.selectedGenderValue, super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        initialValue: "",
        itemBuilder: (context) {
          return [
            AppLocalizations.of(context)!.gendermale,
            AppLocalizations.of(context)!.genderfemale,
            AppLocalizations.of(context)!.genderother
          ].map((str) {
            return PopupMenuItem(
              value: str,
              child: CustomText(
                title: str,
                fontSize: 14,
                textColor: const Color(0xff444444),
              ),
            );
          }).toList();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomText(
              title: selectedGenderValue == "" ? AppLocalizations.of(context)!.genderprofile : selectedGenderValue,
              fontSize: 14,
              textColor: const Color(0xff444444),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_drop_down_outlined,
              size: 20,
            ),
          ],
        ),
        onSelected: (gender) async {
          selectedGender(gender);
        });
  }
}
