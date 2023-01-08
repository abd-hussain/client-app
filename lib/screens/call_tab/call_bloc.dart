import 'package:client_app/locator.dart';
import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/models/https/event_appointment.dart';
import 'package:client_app/sevices/event_services.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../sevices/appointments_service.dart';

class CallBloc extends Bloc<FilterService> {
  final ValueNotifier<List<CalenderMeetings>> eventsmeetingsListNotifier = ValueNotifier<List<CalenderMeetings>>([]);

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<List<Category>?> listOfCategories() async {
    final api = await service.categories();
    if (api.data != null) {
      return api.data!..sort((a, b) => a.id!.compareTo(b.id!));
    }
    return null;
  }

  getAppointmentsAndEvents() {
    _getClientAppointments();
    _getClientEventAppointments();
  }

  Future<void> _getClientAppointments() async {
    List<CalenderMeetings> list = [];

    locator<AppointmentsService>().getClientAppointments().then((value) {
      if (value.data != null) {
        for (AppointmentData item in value.data!) {
          list.add(CalenderMeetings(
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
          ));
        }
        eventsmeetingsListNotifier.value = list;
      }
    });
  }

  Future<void> _getClientEventAppointments() async {
    List<CalenderMeetings> list = eventsmeetingsListNotifier.value;

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

        eventsmeetingsListNotifier.value = list;
      }
    });
  }

  Future<void> cancelAppointment({required int id}) {
    return locator<AppointmentsService>().cancelAppointment(id: id);
  }

  CalenderMeetings? checkIfThereIsAnyMeetingTodayAndReturnTheNearsOne(List<CalenderMeetings> listOfData) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    List<CalenderMeetings> newList = [];
    for (var appointment in listOfData) {
      if (DateTime(appointment.fromTime.year, appointment.fromTime.month, appointment.fromTime.day) == today) {
        newList.add(appointment);
      }
    }
    if (newList.isNotEmpty) {
      CalenderMeetings returnedAppointment = newList[0];

      for (CalenderMeetings appoint in newList) {
        if (appoint.fromTime.isBefore(returnedAppointment.fromTime)) {
          returnedAppointment = appoint;
        }
      }
      return returnedAppointment;
    } else {
      return null;
    }
  }

  @override
  onDispose() {}
}
