import 'package:client_app/screens/account_tab/account_screen.dart';
import 'package:client_app/screens/archive/archive_details_screen.dart';
import 'package:client_app/screens/archive/archive_screen.dart';
import 'package:client_app/screens/booking_meeting/booking_screen.dart';
import 'package:client_app/screens/call_tab/call_screen.dart';
import 'package:client_app/screens/categories_tab/categories_screen.dart';
import 'package:client_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:client_app/screens/home_tab/home_screen.dart';
import 'package:client_app/screens/inside_call/inside_call_screen.dart';
import 'package:client_app/screens/invite_friends/invite_friends_screen.dart';
import 'package:client_app/screens/login/first_step/login_first_step_screen.dart';
import 'package:client_app/screens/login/fourth_step/login_fourth_step_screen.dart';
import 'package:client_app/screens/login/secound_step/login_secound_step_screen.dart';
import 'package:client_app/screens/login/third_step/login_third_step_screen.dart';
import 'package:client_app/screens/main_contaner/main_container.dart';
import 'package:client_app/screens/mentor_profile/mentor_profile_screen.dart';
import 'package:client_app/screens/mycalender_tab/mycalender_screen.dart';
import 'package:client_app/screens/notifications/notifications_screen.dart';
import 'package:client_app/screens/report/report_screen.dart';
import 'package:client_app/screens/setup_screen/setup_screen.dart';
import 'package:client_app/screens/tutorials/tutorials_screen.dart';
import 'package:client_app/screens/web_view/web_view_screen.dart';
import 'package:flutter/material.dart';

class RoutesConstants {
  static const String initialRoute = 'initScreen';
  static const String loginFirstStepRoute = 'loginFirstStepRoute';
  static const String loginSecoundStepRoute = 'loginSecoundStepRoute';
  static const String loginThirdStepRoute = 'loginThirdStepRoute';
  static const String loginFourthStepRoute = 'loginFourthStepRoute';

  static const String mainContainer = 'mainContainer';
  static const String homeScreen = 'homeScreen';
  static const String categoriesScreen = 'categoriesScreen';
  static const String calenderScreen = 'calenderScreen';
  static const String accountScreen = 'accountScreen';
  static const String notificationsScreen = 'notificationsScreen';
  static const String webViewScreen = 'webViewScreen';
  static const String inviteFriendScreen = 'inviteFriendScreen';
  static const String tutorialsScreen = 'tutorialsScreen';
  static const String editProfileScreen = 'editProfileScreen';
  static const String reportScreen = 'reportScreen';
  static const String archiveScreen = 'archiveScreen';
  static const String archiveDetailsScreen = 'archiveDetailsScreen';

  static const String callScreen = 'callScreen';
  static const String insideCallScreen = 'InsideCallScreen';
  static const String mentorProfileScreen = 'mentorProfileScreen';
  static const String bookingScreen = 'bookingScreen';
  static const String eventDetailsScreen = 'eventDetailsScreen';
}

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const SetupScreen(),
  RoutesConstants.loginFirstStepRoute: const LoginFirstStepScreen(),
  RoutesConstants.loginSecoundStepRoute: const LoginSecoundStepScreen(),
  RoutesConstants.loginThirdStepRoute: const LoginThirdStepScreen(),
  RoutesConstants.loginFourthStepRoute: const LoginFourthStepScreen(),
  RoutesConstants.mainContainer: const MainContainer(),
  RoutesConstants.homeScreen: const HomeScreen(),
  RoutesConstants.categoriesScreen: const CategoriesScreen(),
  RoutesConstants.calenderScreen: const MyCalenderScreen(),
  RoutesConstants.accountScreen: const AccountScreen(),
  RoutesConstants.notificationsScreen: const NotificationsScreen(),
  RoutesConstants.webViewScreen: const WebViewScreen(),
  RoutesConstants.inviteFriendScreen: const InviteFriendsScreen(),
  RoutesConstants.tutorialsScreen: const TutorialsScreen(),
  RoutesConstants.editProfileScreen: const EditProfileScreen(),
  RoutesConstants.reportScreen: const ReportScreen(),
  RoutesConstants.archiveScreen: const ArchiveScreen(),
  RoutesConstants.archiveDetailsScreen: const ArchiveDetailsScreen(),
  RoutesConstants.callScreen: const CallScreen(),
  RoutesConstants.mentorProfileScreen: const MentorProfileScreen(),
  RoutesConstants.bookingScreen: const BookingScreen(),
  RoutesConstants.insideCallScreen: const InsideCallScreen()
};
