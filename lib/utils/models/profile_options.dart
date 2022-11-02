import 'package:flutter/material.dart';

enum AccountButtonType {
  aboutUs,
  inviteFriends,
  reportSuggestion,
  reportProblem,
  notificationSetting,
  country,
  language,
  tutorials,
  shakeSetting
}

class ProfileOptions {
  final IconData icon;
  final String name;
  final String selectedItem;
  final bool switchIcn;
  final AccountButtonType buttonType;

  ProfileOptions(
      {required this.icon,
      required this.name,
      this.selectedItem = "",
      required this.buttonType,
      this.switchIcn = false});
}
