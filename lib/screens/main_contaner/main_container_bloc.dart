import 'dart:async';

import 'package:client_app/locator.dart';
import 'package:client_app/screens/main_contaner/widgets/tab_navigator.dart';
import 'package:client_app/sevices/noticitions_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum SelectedTab { home, categories, call, calender, account }

class MainContainerBloc {
  final ValueNotifier<SelectedTab> currentTabIndexNotifier =
      ValueNotifier<SelectedTab>(SelectedTab.home);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();

  List<TabNavigator> navTabs = const [
    TabNavigator(initialRoute: RoutesConstants.homeScreen),
    TabNavigator(initialRoute: RoutesConstants.categoriesScreen),
    TabNavigator(initialRoute: RoutesConstants.callScreen),
    TabNavigator(initialRoute: RoutesConstants.calenderScreen),
    TabNavigator(initialRoute: RoutesConstants.accountScreen)
  ];

  SelectedTab returnSelectedtypeDependOnIndex(int index) {
    switch (index) {
      case 0:
        return SelectedTab.home;
      case 1:
        return SelectedTab.categories;
      case 2:
        return SelectedTab.call;
      case 3:
        return SelectedTab.calender;
      default:
        return SelectedTab.account;
    }
  }

  int getSelectedIndexDependOnTab(SelectedTab tab) {
    switch (tab) {
      case SelectedTab.home:
        return 0;
      case SelectedTab.categories:
        return 1;
      case SelectedTab.call:
        return 2;
      case SelectedTab.calender:
        return 3;
      case SelectedTab.account:
        return 4;
      default:
        return 0;
    }
  }

  Future<void> callRegisterTokenRequest() async {
    if (_checkIfUserIsLoggedIn()) {
      final token = box.get(DatabaseFieldConstant.pushNotificationToken);
      if (token != null && token != "") {
        await locator<NotificationsService>().registerToken(token);
      }
    }
  }

  bool _checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }
}
