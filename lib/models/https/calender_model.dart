//TODO :TO BE DELETED

import 'package:client_app/models/https/appointment.dart';

class CalenderMeetings {
  final int? meetingId;
  final int? clientId;
  final int? mentorId;
  final int? appointmentType;
  final double? priceBeforeDiscount;
  final double? priceAfterDiscount;
  final AppointmentsState state;
  final String? noteFromClient;
  final String? noteFromMentor;
  final String? channelId;
  final String? profileImg;
  final String? mentorPrefix;
  final String? mentorFirstName;
  final String? mentorLastName;
  final int? categoryId;
  final String? categoryName;
  final DateTime fromTime;
  final DateTime toTime;

  const CalenderMeetings({
    required this.meetingId,
    required this.clientId,
    required this.mentorId,
    required this.appointmentType,
    required this.priceBeforeDiscount,
    required this.priceAfterDiscount,
    required this.state,
    required this.noteFromClient,
    required this.noteFromMentor,
    required this.channelId,
    this.profileImg,
    required this.mentorPrefix,
    required this.mentorFirstName,
    required this.mentorLastName,
    required this.categoryId,
    required this.categoryName,
    required this.fromTime,
    required this.toTime,
  });
}
