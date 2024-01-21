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

  // Future<void> _getClientAppointments() async {
  //   List<CalenderMeetings> list = [];

  //   await locator<AppointmentsService>().getClientAppointments().then((value) {
  //     if (value.data != null) {
  //       for (AppointmentData item in value.data!) {
  //         final newItem = CalenderMeetings(
  //           meetingId: item.id,
  //           clientId: item.clientId,
  //           mentorId: item.mentorId,
  //           appointmentType: item.appointmentType,
  //           priceBeforeDiscount: item.priceBeforeDiscount,
  //           priceAfterDiscount: item.priceAfterDiscount,
  //           state: handleMeetingState(item.state!),
  //           noteFromClient: item.noteFromClient,
  //           noteFromMentor: item.noteFromMentor,
  //           profileImg: item.profileImg,
  //           mentorPrefix: item.mentorPrefix,
  //           mentorFirstName: item.mentorFirstName,
  //           mentorLastName: item.mentorLastName,
  //           categoryId: item.categoryId,
  //           categoryName: item.categoryName,
  //           fromTime: DateTime.parse(item.dateFrom!),
  //           toTime: DateTime.parse(item.dateTo!),
  //           channelId: item.channelId,
  //         );
  //         list.add(newItem);
  //       }
  //     }
  //   });
  //   meetingsListNotifier.value = list;
  // }

  // AppointmentsState handleMeetingState(int index) {
  //   if (index == 1) {
  //     return AppointmentsState.active;
  //   } else if (index == 2) {
  //     return AppointmentsState.mentorCancel;
  //   } else if (index == 3) {
  //     return AppointmentsState.clientCancel;
  //   } else if (index == 4) {
  //     return AppointmentsState.clientMiss;
  //   } else if (index == 5) {
  //     return AppointmentsState.mentorMiss;
  //   } else {
  //     return AppointmentsState.completed;
  //   }
  // }

  Future<void> callRegisterTokenRequest() async {
    if (checkIfUserIsLoggedIn()) {
      final token = box.get(DatabaseFieldConstant.pushNotificationToken);
      if (token != null && token != "") {
        await locator<NotificationsService>().registerToken(token);
      }
    }
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }
}
