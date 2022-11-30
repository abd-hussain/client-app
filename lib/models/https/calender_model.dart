class CalenderMeetings {
  final String mentorName;
  final int mentorId;
  final int meetingId;
  final DateTime fromTime;
  final DateTime toTime;
  const CalenderMeetings(
      {required this.mentorName,
      required this.mentorId,
      required this.meetingId,
      required this.fromTime,
      required this.toTime});
}
