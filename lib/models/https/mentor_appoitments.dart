class MentorAppointmentsResponse {
  List<MentorAppointmentsResponseData>? data;
  String? message;

  MentorAppointmentsResponse({this.data, this.message});

  MentorAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MentorAppointmentsResponseData>[];
      json['data'].forEach((v) {
        data!.add(MentorAppointmentsResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class MentorAppointmentsResponseData {
  String? dateFrom;
  String? dateTo;

  MentorAppointmentsResponseData({this.dateFrom, this.dateTo});

  MentorAppointmentsResponseData.fromJson(Map<String, dynamic> json) {
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
  }
}
