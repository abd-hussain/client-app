import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widget/top_bar.dart';

class LoginFirstStepScreen extends StatelessWidget {
  const LoginFirstStepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(DatabaseBoxConstant.userInfo);

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
              fontSize: 16,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              title: AppLocalizations.of(context)!.login_first_step_desc,
              fontSize: 14,
              textColor: const Color(0xffBFBFBF),
            ),
            const SizedBox(height: 10),
            CustomButton(
              buttonTitle:
                  AppLocalizations.of(context)!.login_first_step_button,
              enableButton: true,
              onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
                RoutesConstants.loginSecoundStepRoute,
              ),
            ),
            const SizedBox(height: 20),
            CustomText(
              title: AppLocalizations.of(context)!.titletermsandconditions,
              fontSize: 12,
              textColor: const Color(0xff444444),
            ),
            TextButton(
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .pushNamed(RoutesConstants.webViewScreen, arguments: {
                AppConstant.webViewPageUrl:
                    box.get(DatabaseFieldConstant.language) == "en"
                        ? AppConstant.termsLink
                        : AppConstant.termsLinkAR,
                AppConstant.pageTitle:
                    AppLocalizations.of(context)!.termsandconditions
              }),
              child: CustomText(
                title: AppLocalizations.of(context)!.termsandconditions,
                fontSize: 12,
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
                    fontWeight: FontWeight.bold,
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
