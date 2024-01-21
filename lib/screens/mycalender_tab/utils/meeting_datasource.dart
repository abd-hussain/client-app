import 'package:client_app/models/https/appointment.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeetingDataSource extends CalendarDataSource {
  late final BuildContext context;

  MeetingDataSource(this.context, List<AppointmentData> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].dateFrom!);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments![index].dateTo!);
  }

  @override
  String getSubject(int index) {
    return "${appointments![index].categoryName} ${AppLocalizations.of(context)!.withword} ${appointments![index].suffixeName} ${appointments![index].firstName} ${appointments![index].lastName}";
  }

  @override
  Color getColor(int index) {
    if (_handleMeetingState(appointments![index].state) ==
        AppointmentsState.active) {
      return const Color(0xff006400);
    } else if (_handleMeetingState(appointments![index].state) ==
        AppointmentsState.completed) {
      return const Color(0xff444444);
    } else {
      return const Color(0xff880808);
    }
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  AppointmentsState _handleMeetingState(int index) {
    if (index == 1) {
      return AppointmentsState.active;
    } else if (index == 2) {
      return AppointmentsState.mentorCancel;
    } else if (index == 3) {
      return AppointmentsState.clientCancel;
    } else if (index == 4) {
      return AppointmentsState.clientMiss;
    } else if (index == 5) {
      return AppointmentsState.mentorMiss;
    } else {
      return AppointmentsState.completed;
    }
  }
}
