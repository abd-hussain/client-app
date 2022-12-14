import 'package:client_app/models/https/calender_model.dart';

class MyCalenderBloc {
  List<CalenderMeetings> getDataSource() {
    final List<CalenderMeetings> meetings = [
      CalenderMeetings(
        meetingId: 1,
        mentorName: "Abed",
        mentorId: 4,
        fromTime: DateTime(2022, 11, 29, 12, 55, 1),
        toTime: DateTime(2022, 11, 29, 12, 55, 1).add(
          const Duration(minutes: 30),
        ),
      ),
      CalenderMeetings(
        meetingId: 1,
        mentorName: "layla",
        mentorId: 4,
        fromTime: DateTime(2022, 11, 29, 4, 55, 1),
        toTime: DateTime(2022, 11, 29, 12, 55, 1).add(
          const Duration(minutes: 30),
        ),
      ),
      CalenderMeetings(
        meetingId: 1,
        mentorName: "Sawsan",
        mentorId: 4,
        fromTime: DateTime(2022, 11, 29, 2, 55, 1),
        toTime: DateTime(2022, 11, 29, 12, 55, 1).add(
          const Duration(minutes: 30),
        ),
      ),
    ];

    return meetings;
  }

  @override
  onDispose() {
    throw UnimplementedError();
  }
}
