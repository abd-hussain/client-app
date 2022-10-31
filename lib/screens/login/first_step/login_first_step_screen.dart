import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginFirstStepScreen extends StatelessWidget {
  const LoginFirstStepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CustomText(
              title: "HelpEra",
              fontSize: 30,
              textColor: Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 80),
            Image.asset("assets/images/login_1.png"),
            Expanded(child: Container()),
            CustomText(
              title: AppLocalizations.of(context)!.login_first_step_title,
              fontSize: 14,
              textColor: const Color(0xff444444),
            ),
            CustomText(
              title: AppLocalizations.of(context)!.login_first_step_desc,
              fontSize: 12,
              textColor: const Color(0xffBFBFBF),
            ),
            const SizedBox(height: 20),
            CustomButton(
                buttonTitle: AppLocalizations.of(context)!.login_first_step_button, enableButton: true, onTap: () {}),
            const CustomText(
              title: "By clicking \"SIGN IN / REGISTER\" you will be agreed to the",
              fontSize: 10,
              textColor: Color(0xff444444),
            ),
            TextButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen,
                  arguments: {
                    AppConstant.webViewPageUrl: AppConstant.termsLink,
                    AppConstant.pageTitle: "Terms & Conditions"
                  }),
              child: const CustomText(
                title: "HelpEra Terms & Conditions",
                fontSize: 10,
                textColor: Color(0xff4CB6EA),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: CustomText(
                    title: AppLocalizations.of(context)!.skip,
                    fontSize: 15,
                    textColor: const Color(0xff4CB6EA),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
