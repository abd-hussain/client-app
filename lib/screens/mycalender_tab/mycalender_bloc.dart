import 'package:client_app/locator.dart';
import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/models/https/note_appointment_request.dart';
import 'package:client_app/sevices/appointments_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyCalenderBloc extends Bloc<AppointmentsService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  final ValueNotifier<List<AppointmentData>> meetingsListNotifier =
      ValueNotifier<List<AppointmentData>>([]);

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  Future<void> getClientAppointments(BuildContext context) async {
    await service.getClientAppointments().then((value) {
      if (value.data != null) {
        meetingsListNotifier.value = handleTimingFromUTC(value.data!);
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

  Future<dynamic> cancelMeeting(int meetingId) async {
    return locator<AppointmentsService>().cancelAppointment(id: meetingId);
  }

  Future<dynamic> editNoteMeeting(
      {required int meetingId, required String note}) async {
    return locator<AppointmentsService>().editNoteAppointment(
        noteAppointment: NoteAppointmentRequest(
      id: meetingId,
      comment: note,
    ));
  }

  @override
  onDispose() {}
}
