enum Type { event, meeting }

class CalenderMeetings {
  final int? reservationId;
  final int? meetingId;
  final int? clientId;
  final int? mentorId;
  final int? appointmentType;
  final double? priceBeforeDiscount;
  final double? priceAfterDiscount;
  final int? state;
  final String? noteFromClient;
  final String? noteFromMentor;
  final String? profileImg;
  final String? mentorPrefix;
  final String? mentorFirstName;
  final String? mentorLastName;
  final int? categoryId;
  final String? categoryName;
  final Type type;
  final String? eventImg;
  final DateTime fromTime;
  final DateTime toTime;
  final String? title;

  const CalenderMeetings(
      {required this.reservationId,
      required this.meetingId,
      required this.clientId,
      required this.mentorId,
      required this.appointmentType,
      required this.priceBeforeDiscount,
      required this.priceAfterDiscount,
      required this.state,
      required this.noteFromClient,
      required this.noteFromMentor,
      this.profileImg,
      required this.mentorPrefix,
      required this.mentorFirstName,
      required this.mentorLastName,
      required this.categoryId,
      required this.categoryName,
      required this.type,
      this.eventImg,
      required this.fromTime,
      required this.toTime,
      this.title});
}
