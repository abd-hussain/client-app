import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MentorProfileFooterView extends StatelessWidget {
  final String hourRate;
  final int classMin;
  const MentorProfileFooterView({required this.hourRate, required this.classMin, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE4E9EF),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            CustomText(
              title: hourRate,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff034061),
            ),
            const SizedBox(width: 5),
            const CustomText(
              title: "/",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: Color(0xff034061),
            ),
            const SizedBox(width: 5),
            CustomText(
              title: "$classMin ${AppLocalizations.of(context)!.min}",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff034061),
            ),
            const Expanded(child: SizedBox()),
            CustomButton(
                enableButton: true,
                width: MediaQuery.of(context).size.width * 0.3,
                buttonTitle: AppLocalizations.of(context)!.booknow,
                onTap: () {
                  //TODO
                })
          ],
        ),
      ),
    );
  }
}
