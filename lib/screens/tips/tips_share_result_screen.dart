import 'package:client_app/locator.dart';
import 'package:client_app/screens/tips/tips_bloc.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TipsShareResultScreen extends StatefulWidget {
  const TipsShareResultScreen({super.key});

  @override
  State<TipsShareResultScreen> createState() => _TipsShareResultScreenState();
}

class _TipsShareResultScreenState extends State<TipsShareResultScreen> {
  final bloc = locator<TipsBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff034061),
      appBar: customAppBar(title: ""),
      body: Column(
        children: [
          Expanded(child: Container()),
          Center(
            child: Image.asset(
              "assets/images/questionnaires.png",
              width: 150,
              height: 150,
            ),
          ),
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CustomText(
                    title: AppLocalizations.of(context)!.shareresult,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textColor: const Color(0xff444444),
                    maxLins: 5,
                  ),
                  const CustomText(
                    title: "?",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textColor: Color(0xff444444),
                  ),
                  CustomButton(
                      buttonTitle: AppLocalizations.of(context)!.yes,
                      buttonColor: const Color(0xff554d56),
                      enableButton: true,
                      onTap: () {
                        bloc.submitAnswers();
                        Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.tipsResultScreen);
                      }),
                  CustomButton(
                      buttonTitle: AppLocalizations.of(context)!.no,
                      buttonColor: const Color(0xff554d56),
                      enableButton: true,
                      onTap: () {
                        bloc.submitAnswers();
                        Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.tipsResultScreen);
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
