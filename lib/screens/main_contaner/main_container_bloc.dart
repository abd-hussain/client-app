import 'package:client_app/locator.dart';
import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/models/https/event_appointment.dart';
import 'package:client_app/screens/main_contaner/widgets/tab_navigator.dart';
import 'package:client_app/sevices/appointments_service.dart';
import 'package:client_app/sevices/event_services.dart';
import 'package:client_app/utils/routes.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

enum SelectedTab { home, categories, call, calender, account }

class MainContainerBloc {
  final ValueNotifier<SelectedTab> currentTabIndexNotifier = ValueNotifier<SelectedTab>(SelectedTab.home);
  final ValueNotifier<List<CalenderMeetings>> eventsmeetingsListNotifier = ValueNotifier<List<CalenderMeetings>>([]);

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

  Future<List<CalenderMeetings>> getAppointmentsAndEvents() async {
    List<CalenderMeetings> list = [];

    list.addAll(await _getClientAppointments());
    list.addAll(await _getClientEventAppointments());
    eventsmeetingsListNotifier.value = list;
    return list;
  }

  Future<List<CalenderMeetings>> _getClientAppointments() async {
    List<CalenderMeetings> list = [];

    await locator<AppointmentsService>().getClientAppointments().then((value) {
      if (value.data != null) {
        for (AppointmentData item in value.data!) {
          final newItem = CalenderMeetings(
            meetingId: item.id!,
            mentorPrefix: item.mentorPrefix!,
            mentorFirstName: item.mentorFirstName!,
            mentorLastName: item.mentorLastName!,
            title: null,
            profileImg: item.profileImg,
            mentorId: item.mentorId!,
            categoryName: item.categoryName!,
            type: Type.meeting,
            fromTime: DateTime.parse(item.dateFrom!),
            toTime: DateTime.parse(item.dateTo!),
          );
          list.add(newItem);
        }
      }
    });

    return list;
  }

  Future<List<CalenderMeetings>> _getClientEventAppointments() async {
    List<CalenderMeetings> list = [];

    await locator<EventService>().getclientEventAppointments().then((value) {
      if (value.data != null) {
        for (EventAppointmentData item in value.data!) {
          list.add(CalenderMeetings(
            meetingId: item.eventId!,
            mentorPrefix: item.suffixeName!,
            mentorFirstName: item.firstName!,
            mentorLastName: item.lastName!,
            eventImg: item.image,
            title: item.title!,
            mentorId: item.mentorId!,
            categoryName: item.categoryName!,
            type: Type.event,
            fromTime: DateTime.parse(item.dateFrom!),
            toTime: DateTime.parse(item.dateTo!),
          ));
        }
      }
    });

    return list;
  }
}
