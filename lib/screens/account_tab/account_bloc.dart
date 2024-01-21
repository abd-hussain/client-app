import 'package:client_app/models/profile_options.dart';
import 'package:client_app/my_app.dart';
import 'package:client_app/screens/report/report_screen.dart';
import 'package:client_app/screens/tutorials/tutorials_screen.dart';
import 'package:client_app/sevices/account_service.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';

class AccountBloc extends Bloc<AccountService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  List<ProfileOptions> listOfAccountOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.archive,
        name: AppLocalizations.of(context)!.archive,
        onTap: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.archiveScreen),
      ),
      ProfileOptions(
        icon: Icons.logout,
        name: AppLocalizations.of(context)!.logout,
        onTap: () {
          _logoutView(context);
        },
      ),
      ProfileOptions(
        icon: Ionicons.bag_remove_outline,
        iconColor: Colors.red,
        name: AppLocalizations.of(context)!.deleteaccount,
        nameColor: Colors.red,
        onTap: () {
          _deleteAccountView(context);
        },
      ),
    ];
  }

  List<ProfileOptions> listOfSettingsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.menu_book_rounded,
        name: AppLocalizations.of(context)!.usertutorials,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
            RoutesConstants.tutorialsScreen,
            arguments: {"openFrom": TutorialOpenFrom.account}),
      ),
      ProfileOptions(
        icon: Icons.translate,
        name: AppLocalizations.of(context)!.language,
        selectedItem: box.get(DatabaseFieldConstant.language) == "en"
            ? "English"
            : "العربية",
        onTap: () {
          _changeLanguage(context);
        },
      ),
    ];
  }

  List<ProfileOptions> listOfReachOutUsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.bug_report,
        name: AppLocalizations.of(context)!.reportproblem,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
            RoutesConstants.reportScreen,
            arguments: {AppConstant.argument1: ReportPageType.issue}),
      ),
      ProfileOptions(
        icon: Ionicons.balloon,
        name: AppLocalizations.of(context)!.reportsuggestion,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
            RoutesConstants.reportScreen,
            arguments: {AppConstant.argument1: ReportPageType.suggestion}),
      ),
      ProfileOptions(
        icon: Ionicons.extension_puzzle,
        name: AppLocalizations.of(context)!.joinasmentor,
        onTap: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.webViewScreen, arguments: {
          AppConstant.webViewPageUrl:
              box.get(DatabaseFieldConstant.language) == "ar"
                  ? AppConstant.joinAsMentorLinkAR
                  : AppConstant.joinAsMentorLink,
          AppConstant.pageTitle: AppLocalizations.of(context)!.joinasmentor
        }),
      )
    ];
  }

  List<ProfileOptions> listOfSupportOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Ionicons.color_palette,
        name: AppLocalizations.of(context)!.aboutus,
        onTap: () {
          _openAboutUs(context);
        },
      ),
      ProfileOptions(
        icon: Ionicons.person_add,
        name: AppLocalizations.of(context)!.invite_friends,
        onTap: () {
          _openInviteFriends(context);
        },
      ),
    ];
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  void _openAboutUs(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(RoutesConstants.webViewScreen, arguments: {
      AppConstant.webViewPageUrl:
          box.get(DatabaseFieldConstant.language) == "ar"
              ? AppConstant.aboutusLinkAR
              : AppConstant.aboutusLink,
      AppConstant.pageTitle: AppLocalizations.of(context)!.aboutus
    });
  }

  void _openInviteFriends(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(RoutesConstants.inviteFriendScreen);
  }

  void _changeLanguage(BuildContext context) async {
    await BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.changelanguagemessage,
        sure: () {
          if (box.get(DatabaseFieldConstant.language) == "en") {
            box.put(DatabaseFieldConstant.language, "ar");
            _refreshAppWithLanguageCode(context);
          } else {
            box.put(DatabaseFieldConstant.language, "en");
            _refreshAppWithLanguageCode(context);
          }
        });
  }

  void _refreshAppWithLanguageCode(BuildContext context) async {
    MyApp.of(context)!.rebuild();
  }

  void _logoutView(BuildContext context) {
    var nav = Navigator.of(context, rootNavigator: true);
    BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.areyousurelogout,
        sure: () async {
          box.deleteAll([
            DatabaseFieldConstant.apikey,
            DatabaseFieldConstant.token,
            DatabaseFieldConstant.language,
            DatabaseFieldConstant.userid,
            DatabaseFieldConstant.selectedCountryId,
            DatabaseFieldConstant.selectedCountryFlag,
            DatabaseFieldConstant.selectedCountryName,
            DatabaseFieldConstant.selectedCountryCurrency,
            DatabaseFieldConstant.selectedCountryDialCode,
            DatabaseFieldConstant.selectedCountryMinLenght,
            DatabaseFieldConstant.selectedCountryMaxLenght,
            DatabaseFieldConstant.isUserLoggedIn,
            DatabaseFieldConstant.userFirstName,
            DatabaseFieldConstant.pushNotificationToken,
          ]);

          await nav.pushNamedAndRemoveUntil(
              RoutesConstants.initialRoute, (Route<dynamic> route) => true);
        });
  }

  void _deleteAccountView(BuildContext context) {
    var nav = Navigator.of(context, rootNavigator: true);

    BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.areyousuredeleteaccount,
        sure: () async {
          BottomSheetsUtil().areYouShoureButtomSheet(
              context: context,
              message:
                  AppLocalizations.of(context)!.accountInformationwillbedeleted,
              sure: () async {
                service.removeAccount().whenComplete(() async {
                  final box = await Hive.openBox(DatabaseBoxConstant.userInfo);
                  box.deleteAll([
                    DatabaseFieldConstant.apikey,
                    DatabaseFieldConstant.token,
                    DatabaseFieldConstant.language,
                    DatabaseFieldConstant.userid,
                    DatabaseFieldConstant.selectedCountryId,
                    DatabaseFieldConstant.selectedCountryFlag,
                    DatabaseFieldConstant.selectedCountryName,
                    DatabaseFieldConstant.selectedCountryDialCode,
                    DatabaseFieldConstant.selectedCountryCurrency,
                    DatabaseFieldConstant.selectedCountryMinLenght,
                    DatabaseFieldConstant.selectedCountryMaxLenght,
                    DatabaseFieldConstant.isUserLoggedIn,
                    DatabaseFieldConstant.userFirstName,
                    DatabaseFieldConstant.pushNotificationToken,
                  ]);

                  await nav.pushNamedAndRemoveUntil(
                      RoutesConstants.initialRoute,
                      (Route<dynamic> route) => true);
                });
              });
        });
  }

  @override
  onDispose() {}
}
