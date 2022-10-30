import 'package:client_app/screens/account/account_screen.dart';
import 'package:client_app/screens/categories/categories_screen.dart';
import 'package:client_app/screens/change_country/change_country_screen.dart';
import 'package:client_app/screens/home/home_screen.dart';
import 'package:client_app/screens/invite_friends/invite_friends_screen.dart';
import 'package:client_app/screens/main_contaner/main_container.dart';
import 'package:client_app/screens/mycalender/mycalender_screen.dart';
import 'package:client_app/screens/notifications/notifications_screen.dart';
import 'package:client_app/screens/setup_screen/setup_screen.dart';
import 'package:client_app/screens/web_view/web_view_screen.dart';
import 'package:flutter/material.dart';

class RoutesConstants {
  static const String initialRoute = 'initScreen';
  static const String mainContainer = 'mainContainer';
  static const String homeScreen = 'homeScreen';
  static const String categoriesScreen = 'categoriesScreen';
  static const String calenderScreen = 'calenderScreen';
  static const String accountScreen = 'accountScreen';
  static const String notificationsScreen = 'notificationsScreen';
  static const String webViewScreen = 'webViewScreen';
  static const String inviteFriendScreen = 'inviteFriendScreen';
  static const String changeCountryScreen = 'changeCountryScreen';
}

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const SetupScreen(),
  RoutesConstants.mainContainer: const MainContainer(),
  RoutesConstants.homeScreen: const HomeScreen(),
  RoutesConstants.categoriesScreen: const CategoriesScreen(),
  RoutesConstants.calenderScreen: const MyCalenderScreen(),
  RoutesConstants.accountScreen: const AccountScreen(),
  RoutesConstants.notificationsScreen: const NotificationsScreen(),
  RoutesConstants.webViewScreen: WebViewScreen(),
  RoutesConstants.inviteFriendScreen: const InviteFriendsScreen(),
  RoutesConstants.changeCountryScreen: const ChangeCountryScreen(),
};
