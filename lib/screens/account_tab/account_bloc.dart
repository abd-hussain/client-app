import 'package:client_app/models/profile_options.dart';
import 'package:client_app/myApp.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountBloc {
  BuildContext? mainContext;
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  List<ProfileOptions> listOfAccountOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.loyalty,
        name: AppLocalizations.of(context)!.loyalitypoints,
        onTap: () {},
      ),
      ProfileOptions(
        icon: Icons.logout,
        name: AppLocalizations.of(context)!.logout,
        onTap: () {},
      ),
    ];
  }

  List<ProfileOptions> listOfSettingsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.translate,
        name: AppLocalizations.of(context)!.language,
        selectedItem: box.get(DatabaseFieldConstant.language) == "en" ? "English" : "العربية",
        onTap: () {
          _changeLanguage(context);
        },
      ),
      ProfileOptions(
        icon: Icons.flag,
        name: AppLocalizations.of(context)!.countryprofile,
        selectedItem: "Jordan",
        onTap: () {},
      ),
      ProfileOptions(
        icon: Icons.menu_book_rounded,
        name: AppLocalizations.of(context)!.usertutorials,
        onTap: () {},
      ),
      ProfileOptions(
        icon: Icons.vibration,
        name: AppLocalizations.of(context)!.shaketoreport,
        switchIcn: true,
        onTap: () {},
      ),
      ProfileOptions(
        icon: Icons.notifications_none,
        name: AppLocalizations.of(context)!.allowdisallownotifications,
        switchIcn: true,
        onTap: () {},
      ),
      ProfileOptions(
        icon: Icons.lock,
        name: AppLocalizations.of(context)!.allowdisallowbiometric,
        switchIcn: true,
        onTap: () {},
      ),
    ];
  }

  List<ProfileOptions> listOfReachOutUsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.bug_report,
        name: AppLocalizations.of(context)!.reportproblem,
        onTap: () {},
      ),
      ProfileOptions(
        icon: Icons.auto_fix_high,
        name: AppLocalizations.of(context)!.reportsuggestion,
        onTap: () {},
      )
    ];
  }

  List<ProfileOptions> listOfSupportOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.info,
        name: AppLocalizations.of(context)!.aboutus,
        onTap: () {
          _openAboutUs(context);
        },
      ),
      ProfileOptions(
        icon: Icons.group_add,
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
    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen, arguments: {
      AppConstant.webViewPageUrl: AppConstant.aboutusLink,
      AppConstant.pageTitle: AppLocalizations.of(context)!.aboutus
    });
  }

  void _openInviteFriends(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.inviteFriendScreen);
  }

  void _changeLanguage(BuildContext context) async {
    await BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.changelanguagemessage,
        yes: () {
          if (box.get(DatabaseFieldConstant.language) == "en") {
            box.put(DatabaseFieldConstant.language, "ar");
            _refreshAppWithLanguageCode(context, "ar");
          } else {
            box.put(DatabaseFieldConstant.language, "en");
            _refreshAppWithLanguageCode(context, "en");
          }
        },
        no: () {});
  }

  void _refreshAppWithLanguageCode(BuildContext context, String code) {
    MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: code));
  }
}
