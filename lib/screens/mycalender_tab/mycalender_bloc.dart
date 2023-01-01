import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/sevices/appointments_service.dart';
import 'package:client_app/utils/mixins.dart';

class MyCalenderBloc extends Bloc<AppointmentsService> {
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
          ));
        }
      }
    });

    return dataSource;
  }

  @override
  onDispose() {}
}
