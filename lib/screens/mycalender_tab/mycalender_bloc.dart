import 'package:client_app/locator.dart';
import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/models/https/event_appointment.dart';
import 'package:client_app/sevices/appointments_service.dart';
import 'package:client_app/sevices/event_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyCalenderBloc extends Bloc<AppointmentsService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<List<CalenderMeetings>> getClientAppointments() async {
    List<CalenderMeetings> dataSource = [];
    await service.getClientAppointments().then((value) {
      if (value.data != null) {
        for (AppointmentData appointment in value.data!) {
          dataSource.add(CalenderMeetings(
            meetingId: appointment.id!,
            mentorId: appointment.mentorId!,
            mentorPrefix: appointment.mentorPrefix!,
            mentorFirstName: appointment.mentorFirstName!,
            categoryName: appointment.categoryName!,
            mentorLastName: appointment.mentorLastName!,
            fromTime: DateTime.parse(appointment.dateFrom!),
            toTime: DateTime.parse(appointment.dateTo!),
            type: Type.meeting,
          ));
        }
      }
    });

    return _getClientEventAppointments(dataSource);
  }

  Future<List<CalenderMeetings>> _getClientEventAppointments(List<CalenderMeetings> dataSource) async {
    await locator<EventService>().getclientEventAppointments().then((value) {
      if (value.data != null) {
        for (EventAppointmentData appointment in value.data!) {
          dataSource.add(CalenderMeetings(
            meetingId: appointment.id!,
            mentorId: appointment.mentorId!,
            mentorPrefix: appointment.suffixeName!,
            mentorFirstName: appointment.firstName!,
            categoryName: appointment.categoryName!,
            title: appointment.title!,
            mentorLastName: appointment.lastName!,
            fromTime: DateTime.parse(appointment.dateFrom!),
            toTime: DateTime.parse(appointment.dateTo!),
            type: Type.event,
          ));
        }
      }
    });
    return dataSource;
  }

  Future<dynamic> cancelEvent(int eventID) async {
    return await locator<EventService>().cancelbookedEvent(eventID: eventID);
  }

  Future<dynamic> cancelMeeting(int meetingId) async {
    return locator<AppointmentsService>().cancelAppointment(id: meetingId);
  }

  @override
  onDispose() {}
}
