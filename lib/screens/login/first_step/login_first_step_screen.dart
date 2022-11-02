import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widget/top_bar.dart';

class LoginFirstStepScreen extends StatelessWidget {
  const LoginFirstStepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TopBarWidget(),
            const SizedBox(height: 20),
            Image.asset("assets/images/login_1.png"),
            const SizedBox(height: 20),
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
              buttonTitle: AppLocalizations.of(context)!.login_first_step_button,
              enableButton: true,
              onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.loginSecoundStepRoute),
            ),
            const SizedBox(height: 20),
            CustomText(
              title: AppLocalizations.of(context)!.titletermsandconditions,
              fontSize: 10,
              textColor: const Color(0xff444444),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen, arguments: {
                AppConstant.webViewPageUrl: AppConstant.termsLink,
                AppConstant.pageTitle: AppLocalizations.of(context)!.termsandconditions
              }),
              child: CustomText(
                title: AppLocalizations.of(context)!.termsandconditions,
                fontSize: 10,
                textColor: const Color(0xff4CB6EA),
              ),
            ),
            Expanded(child: Container()),
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
