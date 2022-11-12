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
  shakeSetting,
  logout,
  loyality
}

class ProfileOptions {
  final IconData icon;
  final String name;
  final String selectedItem;
  final bool switchIcn;
  final VoidCallback onTap;

  ProfileOptions(
      {required this.icon, required this.name, this.selectedItem = "", this.switchIcn = false, required this.onTap});
}
