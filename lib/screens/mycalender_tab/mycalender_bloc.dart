import 'package:client_app/locator.dart';
import 'package:client_app/models/https/note_appointment_request.dart';
import 'package:client_app/sevices/appointments_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyCalenderBloc extends Bloc<AppointmentsService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<dynamic> cancelMeeting(int meetingId) async {
    return locator<AppointmentsService>().cancelAppointment(id: meetingId);
  }

  Future<dynamic> editNoteMeeting({required int meetingId, required String note}) async {
    return locator<AppointmentsService>().editNoteAppointment(
        noteAppointment: NoteAppointmentRequest(
      id: meetingId,
      comment: note,
    ));
  }

  @override
  onDispose() {}
}
