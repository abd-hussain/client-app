import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileSubHeader extends StatelessWidget {
  final bool isUserLoggedIn;
  const ProfileSubHeader({required this.isUserLoggedIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isUserLoggedIn
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  optionButton(
                    buttonTitle: AppLocalizations.of(context)!.notifications,
                    icon: Icons.notifications,
                    onTap: () =>
                        Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.notificationsScreen),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration:
                            BoxDecoration(color: const Color(0xff4CB6EA), borderRadius: BorderRadius.circular(5)),
                        height: 10,
                        width: 10,
                      ),
                      Container(
                        color: const Color(0xff4CB6EA),
                        height: 3,
                        width: 50,
                      ),
                      Container(
                        decoration:
                            BoxDecoration(color: const Color(0xff4CB6EA), borderRadius: BorderRadius.circular(5)),
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                  optionButton(
                    buttonTitle: AppLocalizations.of(context)!.archive,
                    icon: Icons.archive,
                    onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.archiveScreen),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  optionButton(
                    buttonTitle: AppLocalizations.of(context)!.login_first_step_button,
                    icon: Icons.account_circle_outlined,
                    onTap: () =>
                        Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.loginFirstStepRoute),
                  ),
                ],
              ),
      ),
    );
  }

  Widget optionButton({required String buttonTitle, required IconData icon, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              color: Color(0xff4CB6EA),
              borderRadius: BorderRadius.all(Radius.circular(27)),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            title: buttonTitle,
            fontSize: 10,
            textColor: const Color(0xff034061),
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
