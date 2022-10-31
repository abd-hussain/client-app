import 'package:client_app/utils/models/profile_options.dart';
import 'package:flutter/material.dart';

class AccountBloc {
  BuildContext? mainContext;

  List<ProfileOptions> listOfAccountOptions = [
    ProfileOptions(
      icon: Icons.card_giftcard,
      name: "Cards",
      buttonType: AccountButtonType.country,
    ),
    ProfileOptions(
      icon: Icons.loyalty,
      name: "Loyality Points",
      buttonType: AccountButtonType.country,
    ),
  ];

  List<ProfileOptions> listOfSettingsOptions = [
    ProfileOptions(
      icon: Icons.translate,
      name: "Language",
      selectedItem: "English",
      buttonType: AccountButtonType.language,
    ),
    ProfileOptions(
      icon: Icons.flag,
      name: "Country",
      selectedItem: "Jordan",
      buttonType: AccountButtonType.country,
    ),
    ProfileOptions(
      icon: Icons.menu_book_rounded,
      name: "User Tutorials",
      buttonType: AccountButtonType.tutorials,
    ),
    ProfileOptions(
      icon: Icons.vibration,
      name: "Shake To Report",
      switchIcn: true,
      buttonType: AccountButtonType.shakeSetting,
    ),
    ProfileOptions(
      icon: Icons.notifications_none,
      name: "Allow/Disallow Notifications",
      switchIcn: true,
      buttonType: AccountButtonType.notificationSetting,
    ),
  ];

  List<ProfileOptions> listOfReachOutUsOptions = [
    ProfileOptions(
      icon: Icons.bug_report,
      name: "Report Problem",
      buttonType: AccountButtonType.reportProblem,
    ),
    ProfileOptions(
      icon: Icons.auto_fix_high,
      name: "Report Suggestion",
      buttonType: AccountButtonType.reportSuggestion,
    )
  ];

  List<ProfileOptions> listOfSupportOptions = [
    ProfileOptions(
      icon: Icons.info,
      name: "About Us",
      buttonType: AccountButtonType.aboutUs,
    ),
    ProfileOptions(
      icon: Icons.group_add,
      name: "Invite Friends",
      buttonType: AccountButtonType.inviteFriends,
    ),
  ];
}
