import 'package:client_app/locator.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/screens/mycalender_tab/utils/get_background_color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<CalenderMeetings> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].fromTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].toTime;
  }

  @override
  String getSubject(int index) {
    return "Call with ${appointments![index].mentorName}";
  }

  @override
  Color getColor(int index) {
    return locator<BackgroundColor>().getRandomColor();
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
