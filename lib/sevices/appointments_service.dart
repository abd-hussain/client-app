import 'package:client_app/models/https/appointment_request.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class AppointmentsService with Service {
  Future<Appointment> getMentorAppointments(int mentorID) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorAppointments,
      queryParam: {"id": mentorID},
    );

    return Appointment.fromJson(response);
  }

  Future<Appointment> getClientAppointments() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.clientAppointments,
    );

    return Appointment.fromJson(response);
  }

  Future<void> bookNewAppointments({required AppointmentRequest appointment}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.bookAppointment,
      postBody: appointment,
    );

    return response;
  }
}