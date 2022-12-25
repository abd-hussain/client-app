class MentorAppointment {
  List<MentorAppointmentData>? data;
  String? message;

  MentorAppointment({this.data, this.message});

  MentorAppointment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MentorAppointmentData>[];
      json['data'].forEach((v) {
        data!.add(MentorAppointmentData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class MentorAppointmentData {
  int? mentorId;
  String? date;

  MentorAppointmentData({this.mentorId, this.date});

  MentorAppointmentData.fromJson(Map<String, dynamic> json) {
    mentorId = json['mentor_id'];
    date = json['date'];
  }
}
