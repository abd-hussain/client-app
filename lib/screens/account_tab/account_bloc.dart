import 'package:client_app/locator.dart';
import 'package:client_app/models/https/update_account_request.dart';
import 'package:client_app/models/profile_options.dart';
import 'package:client_app/myApp.dart';
import 'package:client_app/screens/report/report_screen.dart';
import 'package:client_app/sevices/account_service.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountBloc extends Bloc<AccountService> {
  BuildContext? mainContext;
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  List<ProfileOptions> listOfAccountOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.account_box,
        name: AppLocalizations.of(context)!.editprofileinformations,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.editProfileScreen),
      ),
      ProfileOptions(
        icon: Icons.loyalty,
        name: AppLocalizations.of(context)!.loyalitypoints,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.loyalityScreen),
      ),
      ProfileOptions(
        icon: Icons.logout,
        name: AppLocalizations.of(context)!.logout,
        onTap: () {
          _logoutView(context);
        },
      ),
    ];
  }

  List<ProfileOptions> listOfSettingsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.menu_book_rounded,
        name: AppLocalizations.of(context)!.usertutorials,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.tutorialsScreen),
      ),
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
        selectedItemImage: SizedBox(
          width: 30,
          height: 25,
          child: FadeInImage(
            placeholder: const AssetImage("assets/images/flagPlaceHolderImg.png"),
            image: NetworkImage(box.get(DatabaseFieldConstant.countryFlag), scale: 1),
          ),
        ),
        onTap: () {
          _getListOfCountries(context);
        },
      ),
    ];
  }

  List<ProfileOptions> listOfReachOutUsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.bug_report,
        name: AppLocalizations.of(context)!.reportproblem,
        onTap: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.reportScreen, arguments: {AppConstant.argument1: ReportPageType.issue}),
      ),
      ProfileOptions(
        icon: Icons.auto_fix_high,
        name: AppLocalizations.of(context)!.reportsuggestion,
        onTap: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.reportScreen, arguments: {AppConstant.argument1: ReportPageType.suggestion}),
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

  void _getListOfCountries(BuildContext context) {
    loadingStatus.value = LoadingStatus.inprogress;

    locator<FilterService>().countries().then((value) async {
      var listOfCountries = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      loadingStatus.value = LoadingStatus.finish;
      await BottomSheetsUtil().countryBottomSheet(context, listOfCountries, (p0) async {
        await BottomSheetsUtil().areYouShoureButtomSheet(
            context: context,
            message: AppLocalizations.of(context)!.changecountrymessage,
            sure: () async {
              loadingStatus.value = LoadingStatus.inprogress;
              await box.put(DatabaseFieldConstant.countryFlag, p0.flagImage);
              await box
                  .put(DatabaseFieldConstant.countryId, p0.id)
                  .then((value) => updateProfileCountry(context, p0.id!));
            });
      });
    });
  }

  void _refreshAppWithLanguageCode(BuildContext context) async {
    MyApp.of(context)!.rebuild();
  }

  void _logoutView(BuildContext context) {
    BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.areyousurelogout,
        sure: () async {
          final box = await Hive.openBox(DatabaseBoxConstant.userInfo);
          box.deleteAll([
            DatabaseFieldConstant.apikey,
            DatabaseFieldConstant.token,
            DatabaseFieldConstant.language,
            DatabaseFieldConstant.userid,
            DatabaseFieldConstant.countryId,
            DatabaseFieldConstant.countryFlag,
            DatabaseFieldConstant.isUserLoggedIn,
            DatabaseFieldConstant.userFirstName,
          ]);
          await locator.popScope().then((value) async {
            MyApp.of(context)!.rebuild();
            await Navigator.of(context, rootNavigator: true)
                .pushNamedAndRemoveUntil(RoutesConstants.initialRoute, (Route<dynamic> route) => true);
          });
        });
  }

  void updateProfileCountry(BuildContext context, int countryID) async {
    await service.updateAccount(
      account: UpdateAccountRequest(
        countryId: countryID,
      ),
    );
    loadingStatus.value = LoadingStatus.finish;
  }
}
