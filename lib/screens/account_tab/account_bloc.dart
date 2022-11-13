import 'package:client_app/locator.dart';
import 'package:client_app/models/profile_options.dart';
import 'package:client_app/myApp.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountBloc {
  BuildContext? mainContext;
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  List<ProfileOptions> listOfAccountOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.loyalty,
        name: AppLocalizations.of(context)!.loyalitypoints,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.loyalityScreen),
      ),
      ProfileOptions(
        icon: Icons.account_box,
        name: AppLocalizations.of(context)!.editprofileinformations,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.editProfileScreen),
      ),
      ProfileOptions(
        icon: Icons.phone,
        name: "Change Phone Number",
        onTap: () {
          _changePhoneNumber(context);
        },
      ),
      ProfileOptions(
        icon: Icons.notifications_none,
        name: AppLocalizations.of(context)!.allowdisallownotifications,
        switchIcn: true,
        onTap: () {},
      ),
      ProfileOptions(
        icon: Icons.delete_forever,
        name: "Delete Account",
        onTap: () {},
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
          height: 30,
          child: FadeInImage(
            placeholder: const AssetImage("assets/images/flagPlaceHolderImg.png"),
            image: NetworkImage(box.get(DatabaseFieldConstant.countryFlag), scale: 1),
          ),
        ),
        onTap: () {
          _getListOfCountries(context);
        },
      ),
      ProfileOptions(
        icon: Icons.menu_book_rounded,
        name: AppLocalizations.of(context)!.usertutorials,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.tutorialsScreen),
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
          Navigator.of(context).pop();
        },
        no: () {});
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
            yes: () async {
              loadingStatus.value = LoadingStatus.inprogress;
              await box.put(DatabaseFieldConstant.countryFlag, p0.flagImage);
              await box.put(DatabaseFieldConstant.countryId, p0.id);
              loadingStatus.value = LoadingStatus.finish;
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            no: () {});
      });
    });
  }

  void _refreshAppWithLanguageCode(BuildContext context, String code) {
    MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: code));
  }

  void _changePhoneNumber(BuildContext context) async {
    await BottomSheetsUtil().changePhoneNumberBottomSheet(context: context);
  }

  Widget _logoutView(BuildContext context) {
    return Container(
        //     height: 65,
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.5),
        //           spreadRadius: 0.5,
        //           blurRadius: 5,
        //           offset: const Offset(0, 0.1),
        //         ),
        //       ],
        //     ),
        //     child: InkWell(
        //       onTap: () {
        //         //TODO
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.all(16),
        //         child: Row(
        //           children: [
        //             const Icon(
        //               Icons.logout,
        //               size: 20,
        //               color: Color(0xff034061),
        //             ),
        //             const SizedBox(width: 8),
        //             CustomText(
        //                 title: AppLocalizations.of(context)!.logout,
        //                 fontSize: 16,
        //                 textColor: const Color(0xff034061),
        //                 fontWeight: FontWeight.w500),
        //             Expanded(child: Container()),
        //             const SizedBox(width: 8),
        //             const Icon(
        //               Icons.arrow_forward_ios_outlined,
        //               size: 12,
        //               color: Color(0xffBFBFBF),
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        );
  }
}
