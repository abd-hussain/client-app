import 'package:client_app/locator.dart';
import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/models/https/categories_model.dart';

import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../sevices/appointments_service.dart';

class CallBloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  final ValueNotifier<List<AppointmentData>>
      activeClientAppointmentsListNotifier =
      ValueNotifier<List<AppointmentData>>([]);

  void getActiveClientAppointments(BuildContext context) async {
    await locator<AppointmentsService>()
        .getClientActiveAppointments()
        .then((value) {
      if (value.data != null) {
        activeClientAppointmentsListNotifier.value =
            handleTimingFromUTC(value.data!);
      }
    });
  }

  List<AppointmentData> handleTimingFromUTC(List<AppointmentData> data) {
    int offset = DateTime.now().timeZoneOffset.inHours;

    for (var appoint in data) {
      appoint.dateFrom = _adjustDate(appoint.dateFrom, offset);
      appoint.dateTo = _adjustDate(appoint.dateTo, offset);
    }

    return data;
  }

  String _adjustDate(String? dateString, int offset) {
    if (dateString == null) return '';

    final DateTime date = DateTime.parse(dateString);
    final DateTime adjustedDate = date.add(Duration(hours: offset));

    return adjustedDate.toString();
  }

  Future<List<Category>?> listOfCategories() async {
    final api = await service.categories();
    if (api.data != null) {
      return api.data!..sort((a, b) => a.id!.compareTo(b.id!));
    }
    return null;
  }

  Future<void> cancelAppointment({required int id}) {
    return locator<AppointmentsService>().cancelAppointment(id: id);
  }

  AppointmentData? getNearestMeetingToday(
      List<AppointmentData> activeMeetings) {
    final now = DateTime.now();

    var removeOldMeetingFromTheList = activeMeetings
        .where((meeting) => DateTime.parse(meeting.dateTo!).isAfter(now))
        .toList();

    var filtermeetingavaliablewithing24Hour = removeOldMeetingFromTheList
        .where((meeting) => DateTime.parse(meeting.dateFrom!)
            .isBefore(now.add(const Duration(hours: 24))))
        .toList();

    return filtermeetingavaliablewithing24Hour.isNotEmpty
        ? filtermeetingavaliablewithing24Hour.reduce((closest, current) =>
            DateTime.parse(current.dateFrom!)
                    .isBefore(DateTime.parse(closest.dateFrom!))
                ? current
                : closest)
        : null;
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  bool isTimeDifferencePositive(DateTime timeDifference) {
    return timeDifference.hour > 0 ||
        timeDifference.minute > 0 ||
        timeDifference.second > 0;
  }

  @override
  onDispose() {}
}
