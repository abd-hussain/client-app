class EventAppointment {
  List<EventAppointmentData>? data;
  String? message;

  EventAppointment({this.data, this.message});

  EventAppointment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EventAppointmentData>[];
      json['data'].forEach((v) {
        data!.add(EventAppointmentData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class EventAppointmentData {
  int? id;
  int? clientId;
  int? eventId;
  int? mentorId;
  String? title;
  String? description;
  String? image;
  String? dateFrom;
  String? dateTo;
  String? suffixeName;
  String? firstName;
  String? lastName;
  String? categoryName;

  EventAppointmentData(
      {this.id,
      this.clientId,
      this.eventId,
      this.mentorId,
      this.title,
      this.description,
      this.image,
      this.dateFrom,
      this.dateTo,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.categoryName});

  EventAppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    eventId = json['event_id'];
    mentorId = json['mentor_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    categoryName = json['category_name'];
  }
}
