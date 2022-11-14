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
  final Widget? selectedItemImage;

  final VoidCallback onTap;

  ProfileOptions(
      {required this.icon, required this.name, this.selectedItem = "", this.selectedItemImage, required this.onTap});
}
